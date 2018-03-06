# ::Gdax::TradingPairsWorker
module Gdax
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Gdax::Utils.trading_pairs
    private

    def exchange_name
      'gdax'
    end

  end
end
