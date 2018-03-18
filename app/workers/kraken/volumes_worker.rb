# ::Kraken::VolumesWorker
module Kraken
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Kraken::Utils.volume
    def exchange_name
      'kraken'
    end

  end
end
