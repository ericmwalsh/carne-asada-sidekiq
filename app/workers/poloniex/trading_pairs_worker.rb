# ::Poloniex::TradingPairsWorker
module Poloniex
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Poloniex::Utils.trading_pairs
    private

    def exchange_name
      'poloniex'
    end

  end
end
