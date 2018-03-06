# ::Gdax::PricesS3Worker
module Gdax
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'gdax'
    end

  end
end
