# ::Mercatox::IntervalWorker
module Mercatox
  class IntervalWorker < ::BaseIntervalWorker

    private

    def exchange_name
      'mercatox'
    end

  end
end
