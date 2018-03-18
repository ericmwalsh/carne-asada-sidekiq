# ::Bittrex::VolumesS3Worker
module Bittrex
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'bittrex'
    end

  end
end
