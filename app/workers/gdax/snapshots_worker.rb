# ::Gdax::SnapshotsWorker
module Gdax
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Gdax::Utils.metadata
    private

    def exchange_name
      'gdax'
    end

    def file_headers
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
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['sequence']},
          #{snapshot['price']},
          #{snapshot['open_24h']},
          #{snapshot['volume_24h']},
          #{snapshot['low_24h']},
          #{snapshot['high_24h']},
          #{snapshot['volume_30d']},
          #{snapshot['best_bid']},
          #{snapshot['best_ask']},
          #{timestamp}
        )
      "
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['sequence'].to_f,
        snapshot['price'].to_f,
        snapshot['open_24h'].to_f,
        snapshot['volume_24h'].to_f,
        snapshot['low_24h'].to_f,
        snapshot['high_24h'].to_f,
        snapshot['volume_30d'].to_f,
        snapshot['best_bid'].to_f,
        snapshot['best_ask'].to_f,
      ]
    end

    def table_columns
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
        'best_ask',
        'timestamp'
      ]
    end

  end
end
