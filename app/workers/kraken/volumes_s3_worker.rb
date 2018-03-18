# ::Kraken::VolumesS3Worker
module Kraken
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'kraken'
    end

  end
end
