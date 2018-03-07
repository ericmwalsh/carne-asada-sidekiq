# ::BaseSnapshotsWorker
class BaseSnapshotsWorker < ::BaseWorker

  def perform
    # query and store in memory
    # push to db
    # push to aws
    snapshots = get_metadata
    timestamp = Time.now.to_i

    insert_query_array = []
    mapped_snapshots = [ file_headers ]

    snapshots.each do |snapshot_hash|
      insert_query_array << generate_query_clause(snapshot_hash, timestamp)
      mapped_snapshots << generate_file_body(snapshot_hash)
    end

    insert_query = <<~HEREDOC
      INSERT INTO #{exchange_name}_snapshots (#{table_columns.join(', ')})
      VALUES #{insert_query_array.join(', ')};
    HEREDOC
    filename = "#{exchange_name}/snapshots/#{timestamp}.csv"

    execute_query(insert_query)
    upload_to_s3(filename, mapped_snapshots)
  end

  private

  def get_metadata
    "::ExchangeWrapper::#{exchange_name.capitalize}::Utils".constantize.metadata
  end

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  def file_headers
    raise ::NotImplementedError, 'define this in your worker'
  end

  def generate_query_clause(snapshot, timestamp) # hash, integer
    raise ::NotImplementedError, 'define this in your worker'
  end

  def generate_file_body(snapshot) # hash
    raise ::NotImplementedError, 'define this in your worker'
  end

  def table_columns
    raise ::NotImplementedError, 'define this in your worker'
  end

end
