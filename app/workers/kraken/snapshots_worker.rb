# ::Kraken::SnapshotsWorker
module Kraken
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Kraken::Utils.metadata
    private

    def exchange_name
      'kraken'
    end

    def file_headers
      [
        'symbol',
        'ask_price',
        'ask_whole_lot_volume',
        'ask_lot_volume',
        'bid_price',
        'bid_whole_lot_volume',
        'bid_lot_volume',
        'last_price',
        'last_lot_volume',
        'volume_today',
        'volume_last_24h',
        'vwap_today',
        'vwap_last_24h',
        'trades_today',
        'trades_last_24h',
        'low_today',
        'low_last_24h',
        'high_today',
        'high_last_24h',
        'open'
      ]
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['a'][0],
        snapshot['a'][1],
        snapshot['a'][2],
        snapshot['b'][0],
        snapshot['b'][1],
        snapshot['b'][2],
        snapshot['c'][0],
        snapshot['c'][1],
        snapshot['v'][0],
        snapshot['v'][1],
        snapshot['p'][0],
        snapshot['p'][1],
        snapshot['t'][0],
        snapshot['t'][1],
        snapshot['l'][0],
        snapshot['l'][1],
        snapshot['h'][0],
        snapshot['h'][1],
        snapshot['o']
      ]
    end

    def table_columns
      [
        'symbol',
        'ask_price',
        'ask_whole_lot_volume',
        'ask_lot_volume',
        'bid_price',
        'bid_whole_lot_volume',
        'bid_lot_volume',
        'last_price',
        'last_lot_volume',
        'volume_today',
        'volume_last_24h',
        'vwap_today',
        'vwap_last_24h',
        'trades_today',
        'trades_last_24h',
        'low_today',
        'low_last_24h',
        'high_today',
        'high_last_24h',
        'open',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['a'][0]},
          #{snapshot['a'][1]},
          #{snapshot['a'][2]},
          #{snapshot['b'][0]},
          #{snapshot['b'][1]},
          #{snapshot['b'][2]},
          #{snapshot['c'][0]},
          #{snapshot['c'][1]},
          #{snapshot['v'][0]},
          #{snapshot['v'][1]},
          #{snapshot['p'][0]},
          #{snapshot['p'][1]},
          #{snapshot['t'][0]},
          #{snapshot['t'][1]},
          #{snapshot['l'][0]},
          #{snapshot['l'][1]},
          #{snapshot['h'][0]},
          #{snapshot['h'][1]},
          #{snapshot['o']},
          #{timestamp}
        )
      "
    end

  end
end
