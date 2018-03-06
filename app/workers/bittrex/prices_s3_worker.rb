# ::Bittrex::PricesS3Worker
module Bittrex
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'bittrex'
    end

  end
end
