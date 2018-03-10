# == Schema Information
#
# Table name: cexio_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_cexio_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class CexioPrice < ::ApplicationRecord
  #
end
