# ::Gateio::VolumesWorker
module Gateio
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Gateio::Utils.volume
    def exchange_name
      'gateio'
    end

  end
end
