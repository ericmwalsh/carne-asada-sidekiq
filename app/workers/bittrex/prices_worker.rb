# ::Bittrex::PricesWorker
module Bittrex
  class PricesWorker < ::Bittrex::BaseWorker

    sidekiq_options :queue => 'extract', :retry => false

    def perform
      # query and store in memory
      # push to db
      prices = ::ExchangeWrapper::Bittrex::Utils.prices
      timestamp = Time.now.to_i

      insert_query_array = []

      prices.each do |price_hash|
        # https://rollbar.com/ericmwalsh/carne-asada-sidekiq/items/6/
        if price_hash['price'].present?
          insert_query_array << "('#{price_hash['symbol']}', #{price_hash['price']}, #{timestamp})"
        end
      end

      insert_query = <<~HEREDOC
        INSERT INTO bittrex_prices (symbol, price, timestamp)
        VALUES #{insert_query_array.join(', ')};
      HEREDOC

      execute_query(insert_query)
    end

  end
end
