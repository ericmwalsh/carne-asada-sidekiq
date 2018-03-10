# ::Cexio::PricesWorker
module Cexio
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Cexio::Utils.prices
    private

    def exchange_name
      'cexio'
    end

  end
end
