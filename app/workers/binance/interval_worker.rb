# ::Binance::IntervalWorker
module Binance
  class IntervalWorker < ::BaseIntervalWorker

    private

    def exchange_name
      'binance'
    end

  end
end
