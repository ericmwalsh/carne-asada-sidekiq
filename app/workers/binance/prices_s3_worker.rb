# ::Binance::PricesS3Worker
module Binance
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'binance'
    end

  end
end
