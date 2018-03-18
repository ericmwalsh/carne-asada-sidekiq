# ::BaseVolumesWorker
class BaseVolumesWorker < ::BaseWorker

  sidekiq_options :queue => 'extract', :retry => false

  def perform
    # query and store in memory
    # push to db
    volume = get_volume
    timestamp = Time.now.to_i
    insert_query_array = []

    volume.each do |v_hash|
      insert_query_array << "('#{v_hash['symbol']}', #{v_hash['base_volume']}, #{v_hash['quote_volume']}, #{timestamp})"
    end

    execute_query(
      insert_query(insert_query_array)
    )
  end

  private

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  def get_volume
    "::ExchangeWrapper::#{exchange_name.capitalize}::Utils".constantize.volume
  end

  def insert_query(insert_query_array) # array of strings
    <<~HEREDOC
      INSERT INTO #{exchange_name}_volumes (symbol, base_volume, quote_volume, timestamp)
      VALUES #{insert_query_array.join(', ')};
    HEREDOC
  end
end
