# ::Gdax::BaseWorker
module Gdax
  class BaseWorker < ::BaseWorker

    sidekiq_options :queue => 'extract', :retry => 2
    #
  end
end
