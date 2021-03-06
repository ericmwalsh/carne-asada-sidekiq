# ::BaseWorker
class BaseWorker
  include Sidekiq::Worker

  private

  def execute_query(sql_query) # string
    ActiveRecord::Base.connection.execute(sql_query) if sql_query.present?
  end

  def upload_to_s3(filename, csv_array) # string, array of equal length arrays
    csv = CSV.generate do |csv|
      csv_array.each {|row| csv << row}
    end

    aws_client = Aws::S3::Client.new
    aws_client.put_object(
      bucket: ENV['AWS_S3_BUCKET'],
      key: filename,
      body: csv
    )
  end

  def prepare_sql_value(x)
    x.present? ? x : 'null'
  end

end
