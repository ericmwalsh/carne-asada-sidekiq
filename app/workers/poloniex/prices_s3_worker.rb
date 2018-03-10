# ::Poloniex::PricesS3Worker
module Poloniex
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'poloniex'
    end

  end
end
