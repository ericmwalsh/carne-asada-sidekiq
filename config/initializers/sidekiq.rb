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

# BINANCE

Sidekiq::Cron::Job.create(
  name: 'Binance::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Binance::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Binance::PricesS3Worker - every 30min (offset 1 min)',
  cron: '1,31 * * * *',
  class: 'Binance::PricesS3Worker'
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

Sidekiq::Cron::Job.create(
  name: 'Binance::SnapshotsWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Binance::SnapshotsWorker'
)

# GDAX

Sidekiq::Cron::Job.create(
  name: 'Gdax::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Gdax::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gdax::PricesS3Worker - every 30min (offset 1 min)',
  cron: '1,31 * * * *',
  class: 'Gdax::PricesS3Worker'
)

Sidekiq::Cron::Job.create(
  name: 'Gdax::SymbolsWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gdax::SymbolsWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gdax::TradingPairsWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gdax::TradingPairsWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gdax::SnapshotsWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gdax::SnapshotsWorker'
)

#####

# Sidekiq::Cron::Job.create(
#   name: 'CryptoCompare worker - every day at 00:30',
#   cron: '30 0 * * *',
#   class: 'CryptoCompareWorker'
# )
