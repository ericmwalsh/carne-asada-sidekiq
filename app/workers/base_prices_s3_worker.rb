# ::BasePricesS3Worker
class BasePricesS3Worker < ::BaseWorker

  sidekiq_options :queue => 'extract', :retry => 2

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

    filename = "#{exchange_name}/prices/#{timestamp}.csv"

    upload_to_s3(filename, mapped_prices)
  end

  private

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  # this worker is offset by 1 minute, make sure to account for the spread
  def get_prices(timestamp, duration = 31.minutes)
    price_class = "::#{exchange_name.capitalize}Price".constantize
    execute_query(
      price_class.where('timestamp > ?', (timestamp - duration.to_i)).to_sql
    )
  end

end
