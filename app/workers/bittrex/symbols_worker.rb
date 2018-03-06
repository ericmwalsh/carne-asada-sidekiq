# ::Bittrex::SymbolsWorker
module Bittrex
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Bittrex::Utils.symbols
    private

    def exchange_name
      'bittrex'
    end

  end
end
