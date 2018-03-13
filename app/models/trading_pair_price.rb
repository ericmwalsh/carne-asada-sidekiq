# == Schema Information
#
# Table name: trading_pair_prices
#
#  exchange  :string           not null
#  symbol    :string           not null
#  timestamp :float            not null
#  price_usd :float            not null
#
# Indexes
#
#  index_trading_pair_prices_on_exchange_and_symbol_and_timestamp  (exchange,symbol,timestamp) UNIQUE
#

class TradingPairPrice < ::ApplicationRecord
  #
end
