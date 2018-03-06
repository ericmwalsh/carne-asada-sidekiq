# ::Bittrex::PricesWorker
module Bittrex
  class PricesWorker < ::BasePricesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private

    def exchange_name
      'bittrex'
    end

  end
end
