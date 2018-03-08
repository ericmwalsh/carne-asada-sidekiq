# ::Bitstamp::SymbolsWorker
module Bitstamp
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Bitstamp::Utils.symbols
    private

    def exchange_name
      'bitstamp'
    end

  end
end
