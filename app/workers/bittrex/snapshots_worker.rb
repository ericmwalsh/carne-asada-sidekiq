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
        insert_query_array << "
          ('#{snapshot_hash['symbol']}', #{snapshot_hash['High']},
          #{snapshot_hash['Low']}, #{snapshot_hash['Volume']},
          #{snapshot_hash['Last']}, #{snapshot_hash['BaseVolume']},
          #{snapshot_hash['Bid']}, #{snapshot_hash['Ask']},
          #{snapshot_hash['OpenBuyOrders']}, #{snapshot_hash['OpenSellOrders']},
          #{snapshot_hash['PrevDay']}, #{timestamp})
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
