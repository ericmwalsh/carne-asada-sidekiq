# ::Binance::TradingPairsWorker
module Binance
  class TradingPairsWorker < ::Binance::BaseWorker
    EXCHANGE = 'binance'

    def perform
      # query and store in memory
      # push to db
      # push to aws
      trading_pairs = ::ExchangeWrapper::Binance::Utils.trading_pairs
      timestamp = Time.now.to_i

      # [ [ "ADABTC", "ADA", "BTC" ] ]
      mapped_trading_pairs = [
        [
          'symbol',
          'base_asset',
          'quote_asset'
        ]
      ] + trading_pairs


      filename = "binance/trading_pairs/#{timestamp}.csv"


      determine_trading_pairs(
        trading_pairs,
        existing_trading_pairs,
        timestamp
      )
      upload_to_s3(filename, mapped_trading_pairs)
    end

    def determine_trading_pairs(current_trading_pairs, existing_trading_pairs, timestamp) # array, array, integer
      set_deleted_timestamp = []
      unset_deleted_timestamp = []

      current_trading_pairs_arr = current_trading_pairs.map {|trading_pair_array| trading_pair_array[0]}
      existing_trading_pairs_arr = existing_trading_pairs.map {|trading_pair| trading_pair['symbol']}
      new_trading_pairs_arr = current_trading_pairs_arr - existing_trading_pairs_arr

      new_trading_pairs = new_trading_pairs_arr.map do |symbol|
        current_trading_pairs.find{|trading_pair| trading_pair[0] == symbol}
      end

      existing_trading_pairs.each do |existing_trading_pair|
        # if the trading_pair exists
        if existing_trading_pair['deleted_timestamp'].nil?
          # if it doesn't exist, then it has been deleted
          # add a deleted_timestamp to the trading_pair
          unless current_trading_pairs_arr.include? existing_trading_pair['symbol']
            set_deleted_timestamp << existing_trading_pair['symbol']
          end
        # if it doesn't
        else
          # but now it does (it's been re-added?)
          if current_trading_pairs_arr.include? existing_trading_pair['symbol']
            unset_deleted_timestamp << existing_trading_pair['symbol']
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

      if new_trading_pairs.present?
        create_new_trading_pairs(
          new_trading_pairs
        )
      end
    end

    def create_new_trading_pairs(new_trading_pairs) # array of AR trading pair objects
      insert_query_array = new_trading_pairs.map do |new_trading_pair|
        symbol = new_trading_pair[0]
        base_asset = new_trading_pair[1]
        quote_asset = new_trading_pair[2]
        "('#{EXCHANGE}', '#{symbol}', '#{base_asset}', '#{quote_asset}')"
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
        WHERE trading_pairs.exchange = '#{EXCHANGE}'
        AND trading_pairs.symbol IN ('#{symbols.join("','")}')
      HEREDOC
      execute_query(update_query)
    end

    def existing_trading_pairs
      execute_query(
        ::TradingPair.
          where(
            exchange: EXCHANGE,
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
end
