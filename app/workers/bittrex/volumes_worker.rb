# ::Bittrex::VolumesWorker
module Bittrex
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Bittrex::Utils.volume
    def exchange_name
      'bittrex'
    end

  end
end
