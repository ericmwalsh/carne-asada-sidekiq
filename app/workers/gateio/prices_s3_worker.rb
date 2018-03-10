# ::Gateio::PricesS3Worker
module Gateio
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'gateio'
    end

  end
end
