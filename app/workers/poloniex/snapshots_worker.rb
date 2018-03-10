# ::Poloniex::SnapshotsWorker
module Poloniex
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Poloniex::Utils.metadata
    private

    def exchange_name
      'poloniex'
    end

    def file_headers
      [
        'symbol',
        'last',
        'lowest_ask',
        'highest_bid',
        'percent_change',
        'base_volume',
        'quote_volume',
        'high_24_hr',
        'low_24_hr'
      ]
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['last'],
        snapshot['lowestAsk'],
        snapshot['highestBid'],
        snapshot['percentChange'],
        snapshot['baseVolume'],
        snapshot['quoteVolume'],
        snapshot['high24hr'],
        snapshot['low24hr']
      ]
    end

    def table_columns
      [
        'symbol',
        'last',
        'lowest_ask',
        'highest_bid',
        'percent_change',
        'base_volume',
        'quote_volume',
        'high_24_hr',
        'low_24_hr',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['last']},
          #{snapshot['lowestAsk']},
          #{snapshot['highestBid']},
          #{snapshot['percentChange']},
          #{snapshot['baseVolume']},
          #{snapshot['quoteVolume']},
          #{snapshot['high24hr']},
          #{snapshot['low24hr']},
          #{timestamp}
        )
      "
    end

  end
end
