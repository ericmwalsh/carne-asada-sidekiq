# ::Bitstamp::PricesS3Worker
module Bitstamp
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'bitstamp'
    end

  end
end
