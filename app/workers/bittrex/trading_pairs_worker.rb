# ::Bittrex::TradingPairsWorker
module Bittrex
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Bittrex::Utils.trading_pairs
    private

    def exchange_name
      'bittrex'
    end

  end
end
