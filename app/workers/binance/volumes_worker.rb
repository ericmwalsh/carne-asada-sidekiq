# ::Binance::VolumesWorker
module Binance
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Binance::Utils.volume
    def exchange_name
      'binance'
    end

  end
end
