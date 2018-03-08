# == Schema Information
#
# Table name: bitstamp_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_bitstamp_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class BitstampPrice < ::ApplicationRecord
  #
end
