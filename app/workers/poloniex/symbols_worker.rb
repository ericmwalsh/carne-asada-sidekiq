# ::Poloniex::SymbolsWorker
module Poloniex
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Poloniex::Utils.symbols
    private

    def exchange_name
      'poloniex'
    end

  end
end
