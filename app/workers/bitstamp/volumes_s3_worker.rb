# ::Bitstamp::VolumesS3Worker
module Bitstamp
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'bitstamp'
    end

  end
end
