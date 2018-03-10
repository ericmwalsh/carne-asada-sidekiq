# == Schema Information
#
# Table name: gateio_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_gateio_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class GateioPrice < ::ApplicationRecord
  #
end
