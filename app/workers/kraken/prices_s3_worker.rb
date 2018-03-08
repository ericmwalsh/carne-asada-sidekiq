# ::Kraken::PricesS3Worker
module Kraken
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'kraken'
    end

  end
end
