# ::Gdax::VolumesWorker
module Gdax
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Gdax::Utils.volume
    def exchange_name
      'gdax'
    end

  end
end
