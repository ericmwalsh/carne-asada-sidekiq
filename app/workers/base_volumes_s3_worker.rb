# ::BaseVolumesS3Worker
class BaseVolumesS3Worker < ::BaseWorker

  sidekiq_options :queue => 'extract', :retry => 2

  def perform
    # query from db
    # push to aws
    timestamp = Time.now.to_i
    mapped_volumes = [
      [
        'symbol',
        'base_volume',
        'quote_volume',
        'timestamp'
      ]
    ]

    get_volumes(timestamp).each do |v_hash|
      mapped_volumes << [
        v_hash['symbol'],
        v_hash['base_volume'],
        v_hash['quote_volume'],
        v_hash['timestamp']
      ]
    end

    filename = "#{exchange_name}/volumes/#{timestamp}.csv"

    upload_to_s3(filename, mapped_volumes)
  end

  private

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  # this worker is offset by 1 minute, make sure to account for the spread
  def get_volumes(timestamp, duration = 31.minutes)
    volume_class = "::#{exchange_name.capitalize}Volume".constantize
    execute_query(
      volume_class.where('timestamp > ?', (timestamp - duration.to_i)).to_sql
    )
  end

end
