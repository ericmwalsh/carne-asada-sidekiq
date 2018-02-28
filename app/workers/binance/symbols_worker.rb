# ::Binance::SymbolsWorker
module Binance
  class SymbolsWorker < ::Binance::BaseWorker
    EXCHANGE = 'binance'

    def perform
      # query and store in memory
      # push to db
      # push to aws
      symbols = ::ExchangeWrapper::Binance::Utils.symbols
      timestamp = Time.now.to_i

      mapped_symbols = [
        [
          'symbol'
        ]
      ]

      symbols.each do |symbol|
        mapped_symbols << [
          symbol
        ]
      end


      filename = "binance/symbols/#{timestamp}.csv"

      determine_symbols(symbols, existing_symbols, timestamp)
      upload_to_s3(filename, mapped_symbols)
    end

    def determine_symbols(current_symbols, existing_symbols, timestamp) # array, array, integer
      set_deleted_timestamp = []
      unset_deleted_timestamp = []

      existing_symbols_arr = existing_symbols.map {|symbol| symbol['symbol']}
      new_symbols = current_symbols - existing_symbols_arr

      existing_symbols.each do |existing_symbol|
        # if the symbol exists
        if existing_symbol['deleted_timestamp'].nil?
          # if it doesn't exist, then it has been deleted
          # add a deleted_timestamp to the symbol
          unless current_symbols.include? existing_symbol['symbol']
            set_deleted_timestamp << existing_symbol['symbol']
          end
        # if it doesn't
        else
          # but now it does (it's been re-added?)
          if current_symbols.include? existing_symbol['symbol']
            unset_deleted_timestamp << existing_symbol['symbol']
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

      if new_symbols.present?
        create_new_symbols(
          new_symbols
        )
      end
    end

    def create_new_symbols(new_symbols) # array of strings
      insert_query_array = new_symbols.map do |new_symbol|
        "('#{EXCHANGE}', '#{new_symbol}')"
      end
      insert_query = <<~HEREDOC
        INSERT INTO currencies (exchange, symbol)
        VALUES #{insert_query_array.join(', ')};
      HEREDOC
      execute_query(insert_query)
    end

    def update_deleted_timestamp(timestamp, symbols) # integer (or nil), array of strings
      update_query = <<~HEREDOC
        UPDATE currencies
        SET deleted_timestamp = #{timestamp || 'null'}
        WHERE currencies.exchange = '#{EXCHANGE}'
        AND currencies.symbol IN ('#{symbols.join("','")}')
      HEREDOC
      execute_query(update_query)
    end

    def existing_symbols
      execute_query(
        ::Currency.
          where(
            exchange: EXCHANGE,
          ).
          order(
            symbol: :asc,
            deleted_timestamp: :asc
          ).
          select(
            :symbol,
            :deleted_timestamp
          ).
          to_sql
      )
    end

  end
end
