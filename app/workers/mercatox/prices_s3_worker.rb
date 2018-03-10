# ::Mercatox::PricesS3Worker
module Mercatox
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'mercatox'
    end

  end
end
