# ::Bitstamp::VolumesWorker
module Bitstamp
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Bitstamp::Utils.volume
    def exchange_name
      'bitstamp'
    end

  end
end
