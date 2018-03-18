# ::Poloniex::VolumesS3Worker
module Poloniex
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'poloniex'
    end

  end
end
