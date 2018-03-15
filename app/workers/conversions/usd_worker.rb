# ::Conversions::UsdWorker
module Conversions
  class UsdWorker < ::BaseWorker

    sidekiq_options :queue => 'extract', :retry => 2

    def perform
      yesterday = (Time.now - 1.day).utc.beginning_of_day.strftime('%Y-%m-%d')
      # store today
      ::Conversions::Usd.store_latest
      # store yesterday
      ::Conversions::Usd.store_historical(yesterday)
    end

  end
end
