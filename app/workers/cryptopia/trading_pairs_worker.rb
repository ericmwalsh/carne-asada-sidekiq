# ::Cryptopia::TradingPairsWorker
module Cryptopia
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Cryptopia::Utils.trading_pairs
    private

    def exchange_name
      'cryptopia'
    end

  end
end
