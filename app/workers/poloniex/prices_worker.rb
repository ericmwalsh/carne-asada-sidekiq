# ::Poloniex::PricesWorker
module Poloniex
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Poloniex::Utils.prices
    private

    def exchange_name
      'poloniex'
    end

  end
end
