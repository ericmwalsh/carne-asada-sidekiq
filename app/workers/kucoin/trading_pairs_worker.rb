# ::Kucoin::TradingPairsWorker
module Kucoin
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Kucoin::Utils.trading_pairs
    private

    def exchange_name
      'kucoin'
    end

  end
end
