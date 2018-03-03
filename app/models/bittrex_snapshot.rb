# == Schema Information
#
# Table name: bittrex_snapshots
#
#  symbol           :string           not null
#  high             :float            not null
#  low              :float            not null
#  volume           :float            not null
#  last             :float            not null
#  base_volume      :float            not null
#  bid              :float            not null
#  ask              :float            not null
#  open_buy_orders  :float            not null
#  open_sell_orders :float            not null
#  prev_day         :float            not null
#  timestamp        :float            not null
#
# Indexes
#
#  index_bittrex_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class BittrexSnapshot < ::ApplicationRecord
  #
end
