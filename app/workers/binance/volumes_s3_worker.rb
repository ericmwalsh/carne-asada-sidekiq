# ::Binance::VolumesS3Worker
module Binance
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'binance'
    end

  end
end
