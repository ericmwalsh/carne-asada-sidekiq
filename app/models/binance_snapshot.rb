# == Schema Information
#
# Table name: binance_snapshots
#
#  symbol               :string           not null
#  price_change         :float            not null
#  price_change_percent :float            not null
#  weighted_avg_price   :float            not null
#  high_price           :float            not null
#  low_price            :float            not null
#  volume               :float            not null
#  quote_volume         :float            not null
#  open_time            :float            not null
#  close_time           :float            not null
#  first_id             :integer          not null
#  last_id              :integer          not null
#  count                :integer          not null
#  timestamp            :float            not null
#
# Indexes
#
#  index_binance_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class BinanceSnapshot < ::ApplicationRecord
  #
end
