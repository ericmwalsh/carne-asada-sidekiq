# ::Bittrex::BaseWorker
module Bittrex
  class BaseWorker < ::BaseWorker

    sidekiq_options :queue => 'extract', :retry => 2
    #
  end
end