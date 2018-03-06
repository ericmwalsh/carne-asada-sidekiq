# ::BaseTradingPairsWorker
class BaseTradingPairsWorker < ::BaseWorker

  sidekiq_options :queue => 'extract', :retry => 2

  def perform
    # query and store in memory
    # push to db
    # push to aws
    trading_pairs = get_trading_pairs
    timestamp = Time.now.to_i

    # [ [ "ADABTC", "ADA", "BTC" ] ]
    mapped_trading_pairs = [
      [
        'symbol',
        'base_asset',
        'quote_asset'
      ]
    ] + trading_pairs


    filename = "#{exchange_name}/trading_pairs/#{timestamp}.csv"


    identify_deleted_trading_pairs(
      trading_pairs,
      existing_trading_pairs,
      timestamp
    )
    upload_to_s3(filename, mapped_trading_pairs)
  end

  private

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  def get_trading_pairs
    "::ExchangeWrapper::#{exchange_name.capitalize}::Utils".constantize.trading_pairs
  end

  def identify_deleted_trading_pairs(current_tps, existing_tps, timestamp) # array, array, integer
    set_deleted_timestamp = []
    unset_deleted_timestamp = []

    current_tps_arr = current_tps.map {|trading_pair_array| trading_pair_array[0]}
    existing_tps_arr = existing_tps.map {|trading_pair| trading_pair['symbol']}
    new_tps_arr = current_tps_arr - existing_tps_arr

    new_tps = new_tps_arr.map do |symbol|
      current_tps.find{|trading_pair| trading_pair[0] == symbol}
    end

    existing_tps.each do |existing_tp|
      # if the trading_pair exists
      if existing_tp['deleted_timestamp'].nil?
        # if it doesn't exist, then it has been deleted
        # add a deleted_timestamp to the trading_pair
        unless current_tps_arr.include? existing_tp['symbol']
          set_deleted_timestamp << existing_tp['symbol']
        end
      # if it doesn't
      else
        # but now it does (it's been re-added?)
        if current_tps_arr.include? existing_tp['symbol']
          unset_deleted_timestamp << existing_tp['symbol']
        end
      end
    end

    if set_deleted_timestamp.present?
      update_deleted_timestamp(
        timestamp,
        set_deleted_timestamp
      )
    end

    if unset_deleted_timestamp.present?
      update_deleted_timestamp(
        nil,
        unset_deleted_timestamp
      )
    end

    if new_tps.present?
      create_new_trading_pairs(
        new_tps
      )
    end
  end

  def create_new_trading_pairs(new_trading_pairs) # array of AR trading pair objects
    insert_query_array = new_trading_pairs.map do |new_trading_pair|
      symbol = new_trading_pair[0]
      base_asset = new_trading_pair[1]
      quote_asset = new_trading_pair[2]
      "('#{exchange_name}', '#{symbol}', '#{base_asset}', '#{quote_asset}')"
    end
    insert_query = <<~HEREDOC
      INSERT INTO trading_pairs (exchange, symbol, base_asset, quote_asset)
      VALUES #{insert_query_array.join(', ')};
    HEREDOC
    execute_query(insert_query)
  end

  def update_deleted_timestamp(timestamp, symbols) # integer (or nil), array of strings
    update_query = <<~HEREDOC
      UPDATE trading_pairs
      SET deleted_timestamp = #{timestamp || 'null'}
      WHERE trading_pairs.exchange = '#{exchange_name}'
      AND trading_pairs.symbol IN ('#{symbols.join("','")}')
    HEREDOC
    execute_query(update_query)
  end

  def existing_trading_pairs
    execute_query(
      ::TradingPair.
        where(
          exchange: exchange_name,
        ).
        order(
          symbol: :asc,
          deleted_timestamp: :asc
        ).
        select(
          :symbol,
          :base_asset,
          :quote_asset,
          :deleted_timestamp
        ).
        to_sql
    )
  end

end
