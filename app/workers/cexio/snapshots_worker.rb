# ::Cexio::SnapshotsWorker
module Cexio
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Cexio::Utils.metadata
    private

    def exchange_name
      'cexio'
    end

    def file_headers
      [
        'symbol',
        'bid',
        'ask',
        'low',
        'high',
        'last',
        'volume',
        'volume_30_d'
      ]
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['bid'],
        snapshot['ask'],
        snapshot['low'],
        snapshot['high'],
        snapshot['last'],
        snapshot['volume'],
        snapshot['volume30d']
      ]
    end

    def table_columns
      [
        'symbol',
        'bid',
        'ask',
        'low',
        'high',
        'last',
        'volume',
        'volume_30_d',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['bid']},
          #{snapshot['ask']},
          #{snapshot['low']},
          #{snapshot['high']},
          #{snapshot['last']},
          #{snapshot['volume']},
          #{snapshot['volume30d']},
          #{timestamp}
        )
      "
    end

  end
end
