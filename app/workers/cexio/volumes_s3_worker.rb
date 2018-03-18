# ::Cexio::VolumesS3Worker
module Cexio
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'cexio'
    end

  end
end
