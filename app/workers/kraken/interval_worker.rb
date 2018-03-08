# ::Kraken::IntervalWorker
module Kraken
  class IntervalWorker < ::BaseIntervalWorker

    private

    def exchange_name
      'kraken'
    end

  end
end
