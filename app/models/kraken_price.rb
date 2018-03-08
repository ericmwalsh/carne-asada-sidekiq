# == Schema Information
#
# Table name: kraken_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_kraken_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class KrakenPrice < ::ApplicationRecord
  #
end
