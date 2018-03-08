# ::Bitstamp::TradingPairsWorker
module Bitstamp
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Bitstamp::Utils.trading_pairs
    private

    def exchange_name
      'bitstamp'
    end

  end
end
