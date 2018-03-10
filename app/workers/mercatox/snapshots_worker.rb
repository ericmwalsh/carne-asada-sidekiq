# ::Mercatox::SnapshotsWorker
module Mercatox
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Mercatox::Utils.metadata
    private

    def exchange_name
      'mercatox'
    end

    def file_headers
      [
        'symbol',
        'last',
        'low_24_hr',
        'high_24_hr',
        'percent_change',
        'base_volume',
        'quote_volume',
        'lowest_ask',
        'highest_bid'
      ]
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['last'],
        snapshot['low24hr'],
        snapshot['high24hr'],
        snapshot['percentChange'],
        snapshot['baseVolume'],
        snapshot['quoteVolume'],
        snapshot['lowestAsk'],
        snapshot['highestBid']
      ]
    end

    def table_columns
      [
        'symbol',
        'last',
        'low_24_hr',
        'high_24_hr',
        'percent_change',
        'base_volume',
        'quote_volume',
        'lowest_ask',
        'highest_bid',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{prepare_sql_value(snapshot['last'])},
          #{prepare_sql_value(snapshot['low24hr'])},
          #{prepare_sql_value(snapshot['high24hr'])},
          #{prepare_sql_value(snapshot['percentChange'])},
          #{prepare_sql_value(snapshot['baseVolume'])},
          #{prepare_sql_value(snapshot['quoteVolume'])},
          #{prepare_sql_value(snapshot['lowestAsk'])},
          #{prepare_sql_value(snapshot['highestBid'])},
          #{timestamp}
        )
      "
    end

  end
end
