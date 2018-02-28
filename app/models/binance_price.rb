# == Schema Information
#
# Table name: binance_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_binance_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class BinancePrice < ::ApplicationRecord
  #
end
