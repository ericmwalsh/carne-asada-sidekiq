# == Schema Information
#
# Table name: currency_prices
#
#  symbol    :string           not null
#  timestamp :float            not null
#  price_usd :float            not null
#
# Indexes
#
#  index_currency_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class CurrencyPrice < ::ApplicationRecord
  #
end
