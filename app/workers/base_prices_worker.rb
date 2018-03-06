# ::BasePricesWorker
class BasePricesWorker < ::BaseWorker

  sidekiq_options :queue => 'extract', :retry => false

  def perform
    # query and store in memory
    # push to db
    prices = get_prices
    timestamp = Time.now.to_i
    insert_query_array = []

    prices.each do |price_hash|
      if price_hash['symbol'].present? && price_hash['price'].present?
        insert_query_array << "('#{price_hash['symbol']}', #{price_hash['price']}, #{timestamp})"
      end
    end

    execute_query(
      insert_query(insert_query_array)
    )
  end

  private

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  def get_prices
    "::ExchangeWrapper::#{exchange_name.capitalize}::Utils".constantize.prices
  end

  def insert_query(insert_query_array) # array of strings
    <<~HEREDOC
      INSERT INTO #{exchange_name}_prices (symbol, price, timestamp)
      VALUES #{insert_query_array.join(', ')};
    HEREDOC
  end
end
