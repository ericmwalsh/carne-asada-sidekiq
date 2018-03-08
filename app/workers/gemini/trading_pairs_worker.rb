# ::Gemini::TradingPairsWorker
module Gemini
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Gemini::Utils.trading_pairs
    private

    def exchange_name
      'gemini'
    end

  end
end
