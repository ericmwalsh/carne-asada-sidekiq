# ::Cryptopia::PricesWorker
module Cryptopia
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Cryptopia::Utils.prices
    private

    def exchange_name
      'cryptopia'
    end

  end
end
