# ::Gateio::SymbolsWorker
module Gateio
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Gateio::Utils.symbols
    private

    def exchange_name
      'gateio'
    end

  end
end
