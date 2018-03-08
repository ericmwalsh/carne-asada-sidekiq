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
  name: 'Binance::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Binance::IntervalWorker'
)

# GDAX

Sidekiq::Cron::Job.create(
  name: 'Gdax::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Gdax::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gdax::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gdax::IntervalWorker'
)

# BITTREX

Sidekiq::Cron::Job.create(
  name: 'Bittrex::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Bittrex::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Bittrex::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Bittrex::IntervalWorker'
)

# GEMINI

Sidekiq::Cron::Job.create(
  name: 'Gemini::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Gemini::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gemini::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gemini::IntervalWorker'
)

# KRAKEN

Sidekiq::Cron::Job.create(
  name: 'Kraken::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Kraken::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Kraken::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Kraken::IntervalWorker'
)

# BITSTAMP

Sidekiq::Cron::Job.create(
  name: 'Bitstamp::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Bitstamp::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Bitstamp::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Bitstamp::IntervalWorker'
)

#####

# Sidekiq::Cron::Job.create(
#   name: 'CryptoCompare worker - every day at 00:30',
#   cron: '30 0 * * *',
#   class: 'CryptoCompareWorker'
# )
