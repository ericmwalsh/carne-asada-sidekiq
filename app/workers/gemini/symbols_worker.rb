# ::Gemini::SymbolsWorker
module Gemini
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Gemini::Utils.symbols
    private

    def exchange_name
      'gemini'
    end

  end
end
