# ::Cexio::PricesS3Worker
module Cexio
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'cexio'
    end

  end
end
