# ::Gemini::VolumesWorker
module Gemini
  class VolumesWorker < ::BaseVolumesWorker

    sidekiq_options :queue => 'extract', :retry => false

    private
    # ::ExchangeWrapper::Gemini::Utils.volume
    def exchange_name
      'gemini'
    end

  end
end
