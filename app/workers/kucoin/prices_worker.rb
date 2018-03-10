# ::Kucoin::PricesWorker
module Kucoin
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Kucoin::Utils.prices
    private

    def exchange_name
      'kucoin'
    end

  end
end
