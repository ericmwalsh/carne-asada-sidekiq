# ::Gemini::VolumesS3Worker
module Gemini
  class VolumesS3Worker < ::BaseVolumesS3Worker

    private

    def exchange_name
      'gemini'
    end

  end
end
