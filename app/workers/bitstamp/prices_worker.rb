# ::Bitstamp::PricesWorker
module Bitstamp
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Bitstamp::Utils.prices
    private

    def exchange_name
      'bitstamp'
    end

  end
end
