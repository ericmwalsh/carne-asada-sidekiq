# == Schema Information
#
# Table name: cryptopia_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_cryptopia_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class CryptopiaPrice < ::ApplicationRecord
  #
end
