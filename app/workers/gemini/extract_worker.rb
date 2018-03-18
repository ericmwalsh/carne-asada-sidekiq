# ::Gemini::ExtractWorker
module Gemini
  class ExtractWorker < ::BaseExtractWorker

    private

    def exchange_name
      'gemini'
    end

  end
end
