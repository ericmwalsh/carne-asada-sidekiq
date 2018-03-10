# ::Mercatox::TradingPairsWorker
module Mercatox
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Mercatox::Utils.trading_pairs
    private

    def exchange_name
      'mercatox'
    end

  end
end
