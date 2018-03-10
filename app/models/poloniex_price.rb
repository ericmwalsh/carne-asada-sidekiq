# == Schema Information
#
# Table name: poloniex_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_poloniex_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class PoloniexPrice < ::ApplicationRecord
  #
end
