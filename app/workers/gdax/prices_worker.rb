# ::Gdax::PricesWorker
module Gdax
  class PricesWorker < ::Gdax::BaseWorker

    def perform
      # query and store in memory
      # push to db
      # push to aws
      prices = ::ExchangeWrapper::Gdax::Utils.prices
      timestamp = Time.now.to_i

      insert_query_array = []
      # mapped_prices = [
      #   [
      #     'symbol',
      #     'price'
      #   ]
      # ]

      prices.each do |price_hash|
        insert_query_array << "('#{price_hash['symbol']}', #{price_hash['price']}, #{timestamp})"
        # mapped_prices << [
        #   price_hash['symbol'],
        #   price_hash['price']
        # ]
      end

      insert_query = <<~HEREDOC
        INSERT INTO gdax_prices (symbol, price, timestamp)
        VALUES #{insert_query_array.join(', ')};
      HEREDOC
      # filename = "gdax/prices/#{timestamp}.csv"

      execute_query(insert_query)
      # upload_to_s3(filename, mapped_prices)
    end

  end
end
