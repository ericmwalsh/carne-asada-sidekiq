# ::Cryptopia::VolumesS3Worker
module Cryptopia
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'cryptopia'
    end

  end
end
