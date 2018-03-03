# ::Gdax::SnapshotsWorker
module Gdax
  class SnapshotsWorker < ::Gdax::BaseWorker

    def perform
      # query and store in memory
      # push to db
      # push to aws
      snapshots = ::ExchangeWrapper::Gdax::Utils.metadata
      timestamp = Time.now.to_i

      insert_query_array = []
      mapped_snapshots = [
        [
          'symbol',
          'sequence',
          'price',
          'open_24h',
          'volume_24h',
          'low_24h',
          'high_24h',
          'volume_30d',
          'best_bid',
          'best_ask'
        ]
      ]

      snapshots.each do |snapshot_hash|
        insert_query_array << "
          ('#{snapshot_hash['symbol']}', #{snapshot_hash['sequence']},
          #{snapshot_hash['price']}, #{snapshot_hash['open_24h']},
          #{snapshot_hash['volume_24h']}, #{snapshot_hash['low_24h']},
          #{snapshot_hash['high_24h']}, #{snapshot_hash['volume_30d']},
          #{snapshot_hash['best_bid']}, #{snapshot_hash['best_ask']},
          #{timestamp})
        "
        mapped_snapshots << [
          snapshot_hash['symbol'],
          snapshot_hash['sequence'].to_f,
          snapshot_hash['price'].to_f,
          snapshot_hash['open_24h'].to_f,
          snapshot_hash['volume_24h'].to_f,
          snapshot_hash['low_24h'].to_f,
          snapshot_hash['high_24h'].to_f,
          snapshot_hash['volume_30d'].to_f,
          snapshot_hash['best_bid'].to_f,
          snapshot_hash['best_ask'].to_f,
        ]
      end

      insert_query = <<~HEREDOC
        INSERT INTO gdax_snapshots (symbol, sequence, price, open_24h, volume_24h,
        low_24h, high_24h, volume_30d, best_bid, best_ask, timestamp)
        VALUES #{insert_query_array.join(', ')};
      HEREDOC
      filename = "gdax/snapshots/#{timestamp}.csv"

      execute_query(insert_query)
      upload_to_s3(filename, mapped_snapshots)
    end

  end
end
