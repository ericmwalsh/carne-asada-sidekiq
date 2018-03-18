# ::Cexio::VolumesWorker
module Cexio
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Cexio::Utils.volume
    def exchange_name
      'cexio'
    end

  end
end
