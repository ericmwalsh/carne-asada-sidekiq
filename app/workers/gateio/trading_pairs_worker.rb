# ::Gateio::TradingPairsWorker
module Gateio
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Gateio::Utils.trading_pairs
    private

    def exchange_name
      'gateio'
    end

  end
end
