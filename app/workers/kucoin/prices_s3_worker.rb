# ::Kucoin::PricesS3Worker
module Kucoin
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'kucoin'
    end

  end
end
