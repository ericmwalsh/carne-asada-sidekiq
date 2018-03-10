# ::Cexio::SymbolsWorker
module Cexio
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Cexio::Utils.symbols
    private

    def exchange_name
      'cexio'
    end

  end
end
