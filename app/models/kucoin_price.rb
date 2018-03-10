# == Schema Information
#
# Table name: kucoin_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_kucoin_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class KucoinPrice < ::ApplicationRecord
  #
end
