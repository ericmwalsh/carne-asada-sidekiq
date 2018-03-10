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
  name: 'Binance::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Binance::PricesWorker'
)

Sidekiq::Cron::Job.create(
  name: 'Binance::IntervalWorker - every 30min',
  cron: '*/30 * * * *',
  class: 'Binance::IntervalWorker'
)

# 2. BITSTAMP

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

# 3. BITTREX

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

# 4. CEXIO

Sidekiq::Cron::Job.create(
  name: 'Cexio::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Cexio::PricesWorker'
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
  name: 'Cryptopia::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Cryptopia::PricesWorker'
)

# Sidekiq::Cron::Job.create(
#   name: 'Cryptopia::IntervalWorker - every 30min',
#   cron: '*/30 * * * *',
#   class: 'Cryptopia::IntervalWorker'
# )

# 8. GATEIO

Sidekiq::Cron::Job.create(
  name: 'Gateio::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Gateio::PricesWorker'
)

# Sidekiq::Cron::Job.create(
#   name: 'Gateio::IntervalWorker - every 30min',
#   cron: '*/30 * * * *',
#   class: 'Gateio::IntervalWorker'
# )

# 9. GDAX

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

# 10. GEMINI

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

# 11. KRAKEN

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

# 12. KUCOIN

Sidekiq::Cron::Job.create(
  name: 'Kucoin::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Kucoin::PricesWorker'
)

# Sidekiq::Cron::Job.create(
#   name: 'Kucoin::IntervalWorker - every 30min',
#   cron: '*/30 * * * *',
#   class: 'Kucoin::IntervalWorker'
# )

# 13. MERCATOX

Sidekiq::Cron::Job.create(
  name: 'Mercatox::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Mercatox::PricesWorker'
)

# Sidekiq::Cron::Job.create(
#   name: 'Mercatox::IntervalWorker - every 30min',
#   cron: '*/30 * * * *',
#   class: 'Mercatox::IntervalWorker'
# )

# 14. POLONIEX

Sidekiq::Cron::Job.create(
  name: 'Poloniex::PricesWorker - every 1min',
  cron: '*/1 * * * *',
  class: 'Poloniex::PricesWorker'
)

# Sidekiq::Cron::Job.create(
#   name: 'Poloniex::IntervalWorker - every 30min',
#   cron: '*/30 * * * *',
#   class: 'Poloniex::IntervalWorker'
# )
