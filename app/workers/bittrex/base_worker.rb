# ::Bittrex::BaseWorker
module Bittrex
  class BaseWorker < ::BaseWorker

    sidekiq_options :queue => 'extract', :retry => 2
    #

    private

    def prepare_sql_value(x)
      x.present? ? x : 'null'
    end
  end
end
