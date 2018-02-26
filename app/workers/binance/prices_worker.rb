# ::Binance::PricesWorker
module Binance
  class PricesWorker < ::Binance::BaseWorker

    def perform
      # query and store in memory
      # push to db
      # push to aws
      prices = ::ExchangeWrapper::Binance::Utils.prices
      mapped_prices = [
        [
          'symbol',
          'price'
        ]
      ]

      prices.each do |price_hash|
        mapped_prices << [
          price_hash['symbol'],
          price_hash['price']
        ]
      end

      filename = "binance/prices/#{Time.now.to_i}.csv"

      upload_to_s3(filename, mapped_prices)
    end

  end
end
