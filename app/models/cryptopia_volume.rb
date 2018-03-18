# == Schema Information
#
# Table name: cryptopia_volumes
#
#  symbol       :string           not null
#  base_volume  :float            not null
#  quote_volume :float            not null
#  timestamp    :float            not null
#
# Indexes
#
#  index_cryptopia_volumes_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class CryptopiaVolume < ::ApplicationRecord
  #
end
