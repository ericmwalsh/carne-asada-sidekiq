# ::Binance::PricesWorker
module Binance
  class PricesS3Worker < ::Binance::BaseWorker

    def perform
      # query from db
      # push to aws
      timestamp = Time.now.to_i
      mapped_prices = [
        [
          'symbol',
          'price',
          'timestamp'
        ]
      ]

      get_prices(timestamp).each do |price_hash|
        mapped_prices << [
          price_hash['symbol'],
          price_hash['price'],
          price_hash['timestamp']
        ]
      end

      filename = "binance/prices/#{timestamp}.csv"

      upload_to_s3(filename, mapped_prices)
    end

    private
    # this worker is offset by 1 minute, make sure to account for the spread
    def get_prices(timestamp, duration = 31.minutes)
      execute_query(
        ::BinancePrice.where('timestamp > ?', (timestamp - duration.to_i)).to_sql
      )
    end

  end
end
