# ::Kraken::TradingPairsWorker
module Kraken
  class TradingPairsWorker < ::BaseTradingPairsWorker

    # ::ExchangeWrapper::Kraken::Utils.trading_pairs
    private

    def exchange_name
      'kraken'
    end

  end
end
