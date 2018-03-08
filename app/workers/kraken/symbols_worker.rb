# ::Kraken::SymbolsWorker
module Kraken
  class SymbolsWorker < ::BaseSymbolsWorker

    # ::ExchangeWrapper::Kraken::Utils.symbols
    private

    def exchange_name
      'kraken'
    end

  end
end
