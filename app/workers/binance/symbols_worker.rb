# ::Binance::SymbolsWorker
module Binance
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Binance::Utils.symbols
    private

    def exchange_name
      'binance'
    end

  end
end
