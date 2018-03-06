# ::Binance::TradingPairsWorker
module Binance
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Binance::Utils.trading_pairs
    private

    def exchange_name
      'binance'
    end

  end
end
