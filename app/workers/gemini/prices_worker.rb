# ::Gemini::PricesWorker
module Gemini
  class PricesWorker < ::BasePricesWorker

    # ::ExchangeWrapper::Gemini::Utils.prices
    private

    def exchange_name
      'gemini'
    end

  end
end
