# ::Gdax::IntervalWorker
module Gdax
  class IntervalWorker < ::Gdax::BaseWorker

    sidekiq_options :queue => 'extract', :retry => false

    def perform
      ::Gdax::SymbolsWorker.perform_in(5.seconds)
      ::Gdax::TradingPairsWorker.perform_in(10.seconds)
      ::Gdax::PricesS3Worker.perform_in(15.seconds)
      ::Gdax::SnapshotsWorker.perform_in(20.seconds)
    end

  end
end
