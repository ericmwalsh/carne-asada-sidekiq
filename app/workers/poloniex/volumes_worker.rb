# ::Poloniex::VolumesWorker
module Poloniex
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Poloniex::Utils.volume
    def exchange_name
      'poloniex'
    end

  end
end
