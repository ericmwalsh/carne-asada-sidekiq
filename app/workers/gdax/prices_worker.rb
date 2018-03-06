# ::Gdax::PricesWorker
module Gdax
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Gdax::Utils.prices
    private

    def exchange_name
      'gdax'
    end

  end
end
