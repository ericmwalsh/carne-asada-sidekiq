# ::Gemini::PricesS3Worker
module Gemini
  class PricesS3Worker < ::BasePricesS3Worker

    private

    def exchange_name
      'gemini'
    end

  end
end
