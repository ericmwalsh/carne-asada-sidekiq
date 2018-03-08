# ::Bitstamp::SnapshotsWorker
module Bitstamp
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Bitstamp::Utils.metadata
    private

    def exchange_name
      'bitstamp'
    end

    def file_headers
      [
        'symbol',
        'last',
        'high',
        'low',
        'vwap',
        'volume',
        'bid',
        'ask',
        'open'
      ]
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['last'],
        snapshot['high'],
        snapshot['low'],
        snapshot['vwap'],
        snapshot['volume'],
        snapshot['bid'],
        snapshot['ask'],
        snapshot['open']
      ]
    end

    def table_columns
      [
        'symbol',
        'last',
        'high',
        'low',
        'vwap',
        'volume',
        'bid',
        'ask',
        'open',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['last']},
          #{snapshot['high']},
          #{snapshot['low']},
          #{snapshot['vwap']},
          #{snapshot['volume']},
          #{snapshot['bid']},
          #{snapshot['ask']},
          #{snapshot['open']},
          #{timestamp}
        )
      "
    end

  end
end
