# ::Bitstamp::IntervalWorker
module Bitstamp
  class IntervalWorker < ::BaseIntervalWorker

    private

    def exchange_name
      'bitstamp'
    end

  end
end
