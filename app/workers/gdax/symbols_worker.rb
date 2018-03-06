# ::Gdax::SymbolsWorker
module Gdax
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Gdax::Utils.symbols
    private

    def exchange_name
      'gdax'
    end

  end
end
