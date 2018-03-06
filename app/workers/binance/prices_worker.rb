# ::Binance::PricesWorker
module Binance
  class PricesWorker < ::BasePricesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Binance::Utils.prices
    def exchange_name
      'binance'
    end

  end
end
