# ::Bittrex::IntervalWorker
module Bittrex
  class IntervalWorker < ::Bittrex::BaseWorker

    sidekiq_options :queue => 'extract', :retry => false

    def perform
      ::Bittrex::SymbolsWorker.perform_in(5.seconds)
      ::Bittrex::TradingPairsWorker.perform_in(10.seconds)
      ::Bittrex::PricesS3Worker.perform_in(15.seconds)
      ::Bittrex::SnapshotsWorker.perform_in(20.seconds)
    end

  end
end
