# ::Cryptopia::SnapshotsWorker
module Cryptopia
  class SnapshotsWorker < ::BaseSnapshotsWorker

    # ::ExchangeWrapper::Cryptopia::Utils.metadata
    private

    def exchange_name
      'cryptopia'
    end

    def file_headers
      [
        'symbol',
        'trade_pair_id',
        'ask_price',
        'bid_price',
        'low',
        'high',
        'volume',
        'last_price',
        'buy_volume',
        'sell_volume',
        'change',
        'open',
        'close',
        'base_volume',
        'buy_base_volume',
        'sell_base_volume'
      ]
    end

    def generate_file_body(snapshot) # hash
      [
        snapshot['symbol'],
        snapshot['TradePairId'],
        snapshot['AskPrice'],
        snapshot['BidPrice'],
        snapshot['Low'],
        snapshot['High'],
        snapshot['Volume'],
        snapshot['LastPrice'],
        snapshot['BuyVolume'],
        snapshot['SellVolume'],
        snapshot['Change'],
        snapshot['Open'],
        snapshot['Close'],
        snapshot['BaseVolume'],
        snapshot['BuyBaseVolume'],
        snapshot['SellBaseVolume']
      ]
    end

    def table_columns
      [
        'symbol',
        'trade_pair_id',
        'ask_price',
        'bid_price',
        'low',
        'high',
        'volume',
        'last_price',
        'buy_volume',
        'sell_volume',
        'change',
        'open',
        'close',
        'base_volume',
        'buy_base_volume',
        'sell_base_volume',
        'timestamp'
      ]
    end

    def generate_query_clause(snapshot, timestamp) # hash, integer
      "
        (
          '#{snapshot['symbol']}',
          #{snapshot['TradePairId']},
          #{snapshot['AskPrice']},
          #{snapshot['BidPrice']},
          #{snapshot['Low']},
          #{snapshot['High']},
          #{snapshot['Volume']},
          #{snapshot['LastPrice']},
          #{snapshot['BuyVolume']},
          #{snapshot['SellVolume']},
          #{snapshot['Change']},
          #{snapshot['Open']},
          #{snapshot['Close']},
          #{snapshot['BaseVolume']},
          #{snapshot['BuyBaseVolume']},
          #{snapshot['SellBaseVolume']},
          #{timestamp}
        )
      "
    end

  end
end
