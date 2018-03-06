# ::Binance::PricesWorker
module Binance
  class PricesWorker < ::BasePricesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private

    def exchange_name
      'binance'
    end

  end
end
