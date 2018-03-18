# ::Bitstamp::ExtractWorker
module Bitstamp
  class ExtractWorker < ::BaseExtractWorker

    private

    def exchange_name
      'bitstamp'
    end

  end
end
