# ::Mercatox::VolumesWorker
module Mercatox
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Mercatox::Utils.volume
    def exchange_name
      'mercatox'
    end

  end
end
