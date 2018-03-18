# ::Kraken::ExtractWorker
module Kraken
  class ExtractWorker < ::BaseExtractWorker

    private

    def exchange_name
      'kraken'
    end

  end
end
