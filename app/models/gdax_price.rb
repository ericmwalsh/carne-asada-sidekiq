# == Schema Information
#
# Table name: gdax_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_gdax_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class GdaxPrice < ::ApplicationRecord
  #
end
