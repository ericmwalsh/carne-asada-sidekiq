# ::Mercatox::VolumesS3Worker
module Mercatox
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'mercatox'
    end

  end
end
