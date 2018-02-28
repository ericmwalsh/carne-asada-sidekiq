# Sidekiq.configure_server do |config|
#   config.periodic do |mgr|
#     # https://crontab.guru/

#     # mgr.register(cron_expression, worker_class, job_options={})

#     mgr.register('*/12 * * * *', CoinMarketCapWorker)
#   end
# end

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV['REDIS_URL']
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV['REDIS_URL']
  }
end

Sidekiq::Cron::Job.create(
  name: 'Binance::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Binance::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Binance::SymbolsWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Binance::SymbolsWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Binance::TradingPairsWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Binance::TradingPairsWorker'
)

# Sidekiq::Cron::Job.create(
#   name: 'CryptoCompare worker - every day at 00:30',
#   cron: '30 0 * * *',
#   class: 'CryptoCompareWorker'
# )
