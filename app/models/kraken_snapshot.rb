# == Schema Information
#
# Table name: kraken_snapshots
#
#  symbol               :string           not null
#  ask_price            :float            not null
#  ask_whole_lot_volume :float            not null
#  ask_lot_volume       :float            not null
#  bid_price            :float            not null
#  bid_whole_lot_volume :float            not null
#  bid_lot_volume       :float            not null
#  last_price           :float            not null
#  last_lot_volume      :float            not null
#  volume_today         :float            not null
#  volume_last_24h      :float            not null
#  vwap_today           :float            not null
#  vwap_last_24h        :float            not null
#  trades_today         :float            not null
#  trades_last_24h      :float            not null
#  low_today            :float            not null
#  low_last_24h         :float            not null
#  high_today           :float            not null
#  high_last_24h        :float            not null
#  open                 :float            not null
#  timestamp            :float            not null
#
# Indexes
#
#  index_kraken_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class KrakenSnapshot < ::ApplicationRecord
  #
end
