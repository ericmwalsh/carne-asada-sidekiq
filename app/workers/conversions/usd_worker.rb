# ::Conversions::UsdWorker
module Conversions
  class UsdWorker < ::BaseWorker

    sidekiq_options :queue => 'extract', :retry => 2

    def perform
      today = Time.now.utc.beginning_of_day
      yesterday = (today - 1.day)
      # store today
      ::Conversions::Usd.store_historical(today.strftime('%Y-%m-%d'))
      # store yesterday
      ::Conversions::Usd.store_historical(yesterday.strftime('%Y-%m-%d'))
    end

  end
end
