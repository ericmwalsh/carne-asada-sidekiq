# ::Binance::SymbolsWorker
module Binance
  class SymbolsWorker < ::Binance::BaseWorker

    def perform
      # query and store in memory
      # push to db
      # push to aws
      symbols = ::ExchangeWrapper::Binance::Utils.symbols
      timestamp = Time.now.to_i

      insert_query_array = []
      mapped_symbols = [
        [
          'symbol'
        ]
      ]

      symbols.each do |symbol|
        # insert_query_array << "('#{price_hash['symbol']}', #{price_hash['price']}, #{timestamp})"
        mapped_symbols << [
          symbol
        ]
      end

      # insert_query = "
      #   INSERT INTO binance_prices (symbol, price, timestamp)
      #   VALUES #{insert_query_array.join(', ')};
      # "
      filename = "binance/symbols/#{timestamp}.csv"

      # execute_query(insert_query)
      upload_to_s3(filename, mapped_symbols)
    end

  end
end
