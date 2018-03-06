# ::Bittrex::SnapshotsWorker
module Bittrex
  class SnapshotsWorker < ::Bittrex::BaseWorker

    def perform
      # query and store in memory
      # push to db
      # push to aws
      snapshots = ::ExchangeWrapper::Bittrex::Utils.metadata
      timestamp = Time.now.to_i

      insert_query_array = []
      mapped_snapshots = [
        [
          'symbol',
          'high',
          'low',
          'volume',
          'last',
          'base_volume',
          'bid',
          'ask',
          'open_buy_orders',
          'open_sell_orders',
          'prev_day'
        ]
      ]

      snapshots.each do |snapshot_hash|
        # https://rollbar.com/ericmwalsh/carne-asada-sidekiq/items/7/
        # restrictions have been loosened for metadata,
        # only symbol & timestamp must be non-null
        insert_query_array << "
          ('#{snapshot_hash['symbol']}',
          #{prepare_sql_value(snapshot_hash['High'])},
          #{prepare_sql_value(snapshot_hash['Low'])},
          #{prepare_sql_value(snapshot_hash['Volume'])},
          #{prepare_sql_value(snapshot_hash['Last'])},
          #{prepare_sql_value(snapshot_hash['BaseVolume'])},
          #{prepare_sql_value(snapshot_hash['Bid'])},
          #{prepare_sql_value(snapshot_hash['Ask'])},
          #{prepare_sql_value(snapshot_hash['OpenBuyOrders'])},
          #{prepare_sql_value(snapshot_hash['OpenSellOrders'])},
          #{prepare_sql_value(snapshot_hash['PrevDay'])},
          #{timestamp})
        "
        mapped_snapshots << [
          snapshot_hash['symbol'],
          snapshot_hash['High'],
          snapshot_hash['Low'],
          snapshot_hash['Volume'],
          snapshot_hash['Last'],
          snapshot_hash['BaseVolume'],
          snapshot_hash['Bid'],
          snapshot_hash['Ask'],
          snapshot_hash['OpenBuyOrders'],
          snapshot_hash['OpenSellOrders'],
          snapshot_hash['PrevDay']
        ]
      end

      insert_query = <<~HEREDOC
        INSERT INTO bittrex_snapshots (symbol, high, low, volume, last, base_volume,
        bid, ask, open_buy_orders, open_sell_orders, prev_day, timestamp)
        VALUES #{insert_query_array.join(', ')};
      HEREDOC
      filename = "bittrex/snapshots/#{timestamp}.csv"

      execute_query(insert_query)
      upload_to_s3(filename, mapped_snapshots)
    end

  end
end
