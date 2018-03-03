# ::Binance::SnapshotsWorker
module Binance
  class SnapshotsWorker < ::Binance::BaseWorker

    def perform
      # query and store in memory
      # push to db
      # push to aws
      snapshots = ::ExchangeWrapper::Binance::Utils.metadata
      timestamp = Time.now.to_i

      insert_query_array = []
      mapped_snapshots = [
        [
          'symbol',
          'price_change',
          'price_change_percent',
          'weighted_avg_price',
          'prev_close_price',
          'last_price',
          'last_qty',
          'bid_price',
          'bid_qty',
          'ask_price',
          'ask_qty',
          'open_price',
          'high_price',
          'low_price',
          'volume',
          'quote_volume',
          'open_time',
          'close_time',
          'first_id',
          'last_id',
          'count'
        ]
      ]

      snapshots.each do |snapshot_hash|
        insert_query_array << "
          ('#{snapshot_hash['symbol']}', #{snapshot_hash['priceChange']}, #{snapshot_hash['priceChangePercent']},
          #{snapshot_hash['weightedAvgPrice']}, #{snapshot_hash['highPrice']}, #{snapshot_hash['lowPrice']},
          #{snapshot_hash['volume']}, #{snapshot_hash['quoteVolume']}, #{snapshot_hash['openTime']},
          #{snapshot_hash['closeTime']}, #{snapshot_hash['firstId']}, #{snapshot_hash['lastId']},
          #{snapshot_hash['count']}, #{timestamp})
        "
        mapped_snapshots << [
          snapshot_hash['symbol'],
          snapshot_hash['priceChange'],
          snapshot_hash['priceChangePercent'],
          snapshot_hash['weightedAvgPrice'],
          snapshot_hash['prevClosePrice'],
          snapshot_hash['lastPrice'],
          snapshot_hash['lastQty'],
          snapshot_hash['bidPrice'],
          snapshot_hash['bidQty'],
          snapshot_hash['askPrice'],
          snapshot_hash['askQty'],
          snapshot_hash['openPrice'],
          snapshot_hash['highPrice'],
          snapshot_hash['lowPrice'],
          snapshot_hash['volume'],
          snapshot_hash['quoteVolume'],
          snapshot_hash['openTime'],
          snapshot_hash['closeTime'],
          snapshot_hash['firstId'],
          snapshot_hash['lastId'],
          snapshot_hash['count']
        ]
      end

      insert_query = <<~HEREDOC
        INSERT INTO binance_snapshots (symbol, price_change, price_change_percent, weighted_avg_price, high_price,
        low_price, volume, quote_volume, open_time, close_time, first_id, last_id, count, timestamp)
        VALUES #{insert_query_array.join(', ')};
      HEREDOC
      filename = "binance/snapshots/#{timestamp}.csv"

      execute_query(insert_query)
      upload_to_s3(filename, mapped_snapshots)
    end

  end
end
