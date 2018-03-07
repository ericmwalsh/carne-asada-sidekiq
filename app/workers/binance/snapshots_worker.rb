# ::Binance::SnapshotsWorker
module Binance
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Binance::Utils.metadata
    private

    def exchange_name
      'binance'
    end

    def file_headers
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
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['priceChange']},
          #{snapshot['priceChangePercent']},
          #{snapshot['weightedAvgPrice']},
          #{snapshot['highPrice']},
          #{snapshot['lowPrice']},
          #{snapshot['volume']},
          #{snapshot['quoteVolume']},
          #{snapshot['openTime']},
          #{snapshot['closeTime']},
          #{snapshot['firstId']},
          #{snapshot['lastId']},
          #{snapshot['count']},
          #{timestamp}
        )
      "
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['priceChange'],
        snapshot['priceChangePercent'],
        snapshot['weightedAvgPrice'],
        snapshot['prevClosePrice'],
        snapshot['lastPrice'],
        snapshot['lastQty'],
        snapshot['bidPrice'],
        snapshot['bidQty'],
        snapshot['askPrice'],
        snapshot['askQty'],
        snapshot['openPrice'],
        snapshot['highPrice'],
        snapshot['lowPrice'],
        snapshot['volume'],
        snapshot['quoteVolume'],
        snapshot['openTime'],
        snapshot['closeTime'],
        snapshot['firstId'],
        snapshot['lastId'],
        snapshot['count']
      ]
    end

    def table_columns
      [
        'symbol',
        'price_change',
        'price_change_percent',
        'weighted_avg_price',
        'high_price',
        'low_price',
        'volume',
        'quote_volume',
        'open_time',
        'close_time',
        'first_id',
        'last_id',
        'count',
        'timestamp'
      ]
    end

  end
end
