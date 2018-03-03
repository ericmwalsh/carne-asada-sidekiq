# == Schema Information
#
# Table name: gdax_snapshots
#
#  symbol     :string           not null
#  sequence   :float            not null
#  price      :float            not null
#  open_24h   :float            not null
#  volume_24h :float            not null
#  low_24h    :float            not null
#  high_24h   :float            not null
#  volume_30d :float            not null
#  best_bid   :float            not null
#  best_ask   :float            not null
#  timestamp  :float            not null
#
# Indexes
#
#  index_gdax_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class GdaxSnapshot < ::ApplicationRecord
  #
end
