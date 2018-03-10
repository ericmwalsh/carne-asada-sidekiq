# == Schema Information
#
# Table name: mercatox_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_mercatox_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class MercatoxPrice < ::ApplicationRecord
  #
end
