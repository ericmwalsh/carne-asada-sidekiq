# ::Kucoin::SnapshotsWorker
module Kucoin
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Kucoin::Utils.metadata
    private

    def exchange_name
      'kucoin'
    end

    def file_headers
      [
        'symbol',
        'last_deal_price',
        'buy',
        'sell',
        'change',
        'sort',
        'fee_rate',
        'vol_value',
        'high',
        'vol',
        'low',
        'change_rate'
      ]
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['lastDealPrice'],
        snapshot['buy'],
        snapshot['sell'],
        snapshot['change'],
        snapshot['sort'],
        snapshot['feeRate'],
        snapshot['volValue'],
        snapshot['high'],
        snapshot['vol'],
        snapshot['low'],
        snapshot['changeRate']
      ]
    end

    def table_columns
      [
        'symbol',
        'last_deal_price',
        'buy',
        'sell',
        'change',
        'sort',
        'fee_rate',
        'vol_value',
        'high',
        'vol',
        'low',
        'change_rate',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{prepare_sql_value(snapshot['lastDealPrice'])},
          #{prepare_sql_value(snapshot['buy'])},
          #{prepare_sql_value(snapshot['sell'])},
          #{prepare_sql_value(snapshot['change'])},
          #{prepare_sql_value(snapshot['sort'])},
          #{prepare_sql_value(snapshot['feeRate'])},
          #{prepare_sql_value(snapshot['volValue'])},
          #{prepare_sql_value(snapshot['high'])},
          #{prepare_sql_value(snapshot['vol'])},
          #{prepare_sql_value(snapshot['low'])},
          #{prepare_sql_value(snapshot['changeRate'])},
          #{timestamp}
        )
      "
    end

  end
end
