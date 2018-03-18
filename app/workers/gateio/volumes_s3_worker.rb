# ::Gateio::VolumesS3Worker
module Gateio
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'gateio'
    end

  end
end
