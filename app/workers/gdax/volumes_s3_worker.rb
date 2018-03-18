# ::Gdax::VolumesS3Worker
module Gdax
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'gdax'
    end

  end
end
