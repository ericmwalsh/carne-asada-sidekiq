# ::Gemini::SnapshotsWorker
module Gemini
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Gemini::Utils.metadata
    private

    def exchange_name
      'gemini'
    end

    def file_headers
      [
        'symbol',
        'base_volume',
        'quote_volume',
        'bid',
        'ask',
        'last'
      ]
    end

    def generate_file_body(snapshot) # hash
      assets = snapshot['symbol'].split('/') # ['BASE_ASSET', 'QUOTE_ASSET']
      [
        snapshot['symbol'],
        snapshot['volume'][assets[0]],
        snapshot['volume'][assets[1]],
        snapshot['bid'],
        snapshot['ask'],
        snapshot['last'],
      ]
    end

    def table_columns
      [
        'symbol',
        'base_volume',
        'quote_volume',
        'bid',
        'ask',
        'last',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      assets = snapshot['symbol'].split('/') # ['BASE_ASSET', 'QUOTE_ASSET']
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['volume'][assets[0]]},
          #{snapshot['volume'][assets[1]]},
          #{snapshot['bid']},
          #{snapshot['ask']},
          #{snapshot['last']},
          #{timestamp}
        )
      "
    end

  end
end
