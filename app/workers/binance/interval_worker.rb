# ::Binance::IntervalWorker
module Binance
  class IntervalWorker < ::Binance::BaseWorker

    sidekiq_options :queue => 'extract', :retry => false

    def perform
      ::Binance::SymbolsWorker.perform_in(5.seconds)
      ::Binance::TradingPairsWorker.perform_in(10.seconds)
      ::Binance::PricesS3Worker.perform_in(15.seconds)
      ::Binance::SnapshotsWorker.perform_in(20.seconds)
    end

  end
end
