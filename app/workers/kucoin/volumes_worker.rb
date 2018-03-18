# ::Kucoin::VolumesWorker
module Kucoin
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Kucoin::Utils.volume
    def exchange_name
      'kucoin'
    end

  end
end
