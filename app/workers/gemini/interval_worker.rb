# ::Gemini::IntervalWorker
module Gemini
  class IntervalWorker < ::BaseIntervalWorker

    private

    def exchange_name
      'gemini'
    end

  end
end
