# ::Cexio::TradingPairsWorker
module Cexio
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Cexio::Utils.trading_pairs
    private

    def exchange_name
      'cexio'
    end

  end
end
