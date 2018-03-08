# ::Kraken::PricesWorker
module Kraken
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Kraken::Utils.prices
    private

    def exchange_name
      'kraken'
    end

  end
end
