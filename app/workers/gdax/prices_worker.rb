# ::Gdax::PricesWorker
module Gdax
  class PricesWorker < ::BasePricesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private

    def exchange_name
      'gdax'
    end

  end
end
