# == Schema Information
#
# Table name: bittrex_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_bittrex_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class BittrexPrice < ::ApplicationRecord
  #
end
