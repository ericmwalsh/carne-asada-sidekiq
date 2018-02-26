# ::Binance::BaseWorker
module Binance
  class BaseWorker < ::BaseWorker

    sidekiq_options :queue => 'extract', :retry => 2
    #
  end
end
