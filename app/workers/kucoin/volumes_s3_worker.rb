# ::Kucoin::VolumesS3Worker
module Kucoin
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'kucoin'
    end

  end
end
