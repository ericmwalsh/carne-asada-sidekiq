# ::Bittrex::SnapshotsWorker
module Bittrex
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Bittrex::Utils.metadata
    private

    def exchange_name
      'bittrex'
    end

    def file_headers
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
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{prepare_sql_value(snapshot['High'])},
          #{prepare_sql_value(snapshot['Low'])},
          #{prepare_sql_value(snapshot['Volume'])},
          #{prepare_sql_value(snapshot['Last'])},
          #{prepare_sql_value(snapshot['BaseVolume'])},
          #{prepare_sql_value(snapshot['Bid'])},
          #{prepare_sql_value(snapshot['Ask'])},
          #{prepare_sql_value(snapshot['OpenBuyOrders'])},
          #{prepare_sql_value(snapshot['OpenSellOrders'])},
          #{prepare_sql_value(snapshot['PrevDay'])},
          #{timestamp}
        )
      "
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['High'],
        snapshot['Low'],
        snapshot['Volume'],
        snapshot['Last'],
        snapshot['BaseVolume'],
        snapshot['Bid'],
        snapshot['Ask'],
        snapshot['OpenBuyOrders'],
        snapshot['OpenSellOrders'],
        snapshot['PrevDay']
      ]
    end

    def table_columns
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
        'prev_day',
        'timestamp'
      ]
    end

  end
end
