# ::Mercatox::SymbolsWorker
module Mercatox
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Mercatox::Utils.symbols
    private

    def exchange_name
      'mercatox'
    end

  end
end
