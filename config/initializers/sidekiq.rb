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

# 1. BINANCE

Sidekiq::Cron::Job.create(
  name: 'Binance::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Binance::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Binance::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Binance::IntervalWorker'
)

# 2. BITSTAMP

Sidekiq::Cron::Job.create(
  name: 'Bitstamp::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Bitstamp::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Bitstamp::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Bitstamp::IntervalWorker'
)

# 3. BITTREX

Sidekiq::Cron::Job.create(
  name: 'Bittrex::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Bittrex::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Bittrex::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Bittrex::IntervalWorker'
)

# 4. CEXIO

Sidekiq::Cron::Job.create(
  name: 'Cexio::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Cexio::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Cexio::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Cexio::IntervalWorker'
)

# 5. COINBASE

# 6. COSSIO

# 7. CRYPTOPIA

Sidekiq::Cron::Job.create(
  name: 'Cryptopia::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Cryptopia::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Cryptopia::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Cryptopia::IntervalWorker'
)

# 8. GATEIO

Sidekiq::Cron::Job.create(
  name: 'Gateio::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Gateio::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gateio::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gateio::IntervalWorker'
)

# 9. GDAX

Sidekiq::Cron::Job.create(
  name: 'Gdax::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Gdax::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gdax::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gdax::IntervalWorker'
)

# 10. GEMINI

Sidekiq::Cron::Job.create(
  name: 'Gemini::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Gemini::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Gemini::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Gemini::IntervalWorker'
)

# 11. KRAKEN

Sidekiq::Cron::Job.create(
  name: 'Kraken::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Kraken::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Kraken::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Kraken::IntervalWorker'
)

# 12. KUCOIN

Sidekiq::Cron::Job.create(
  name: 'Kucoin::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Kucoin::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Kucoin::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Kucoin::IntervalWorker'
)

# 13. MERCATOX

Sidekiq::Cron::Job.create(
  name: 'Mercatox::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Mercatox::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Mercatox::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Mercatox::IntervalWorker'
)

# 14. POLONIEX

Sidekiq::Cron::Job.create(
  name: 'Poloniex::ExtractWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Poloniex::ExtractWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Poloniex::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Poloniex::IntervalWorker'
)

# Conversions - USD

Sidekiq::Cron::Job.create(
  name: 'Conversions::UsdWorker - every day at 00:30',
  cron: '30 0 * * *',
  class: 'Conversions::UsdWorker'
)
