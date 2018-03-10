# ::Gateio::PricesWorker
module Gateio
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Gateio::Utils.prices
    private

    def exchange_name
      'gateio'
    end

  end
end
