# :: Helpers
module Helpers

  ALIASES = {
    'XBT' => 'BTC',
    'XRB' => 'NANO'
  }

  CURRENCIES_BY_VOLUME = [
    'BTC',
    'ETH',
    'XRP',
    'BCH',
    'LTC',
    'ADA',
    'NEO',
    'XLM',
    'EOS',
    'XEM',
    'XMR',
    'DASH',
    'IOTA',
    'USDT',
    'TRX',
    'VEN',
    'ETC',
    'NANO',
    'LSK',
    'QTUM',
    'OMG',
    'BTG',
    'ICX',
    'BNB',
    'ZEC',
    'DOGE',
    'KCS',
    'XAUR',
    'NZDT',
    'SNET'
  ]

  EXCHANGES = [
    'binance',
    'bitstamp',
    'bittrex',
    'cexio',
    'cryptopia',
    'gateio',
    'gdax',
    'gemini',
    'kraken',
    'kucoin',
    'mercatox',
    'poloniex'
  ]

  def beginning_of_day(timestamp)
    Time.at(timestamp).utc.beginning_of_day.to_i
  end

  def execute_query(sql_query) # string
    ActiveRecord::Base.connection.execute(sql_query) if sql_query.present?
  end

end
