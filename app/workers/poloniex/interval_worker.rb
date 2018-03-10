# ::Poloniex::IntervalWorker
module Poloniex
  class IntervalWorker < ::BaseIntervalWorker

    private

    def exchange_name
      'poloniex'
    end

  end
end
