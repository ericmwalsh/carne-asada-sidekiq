# ::Cryptopia::VolumesWorker
module Cryptopia
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Cryptopia::Utils.volume
    def exchange_name
      'cryptopia'
    end

  end
end
