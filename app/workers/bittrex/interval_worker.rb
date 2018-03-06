# ::Bittrex::IntervalWorker
module Bittrex
  class IntervalWorker < ::BaseIntervalWorker

    private

    def exchange_name
      'bittrex'
    end

  end
end
