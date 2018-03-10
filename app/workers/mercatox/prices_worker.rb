# ::Mercatox::PricesWorker
module Mercatox
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Mercatox::Utils.prices
    private

    def exchange_name
      'mercatox'
    end

  end
end
