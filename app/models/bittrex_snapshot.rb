# == Schema Information
#
# Table name: bittrex_snapshots
#
#  symbol           :string           not null
#  high             :string
#  low              :float
#  volume           :float
#  last             :float
#  base_volume      :float
#  bid              :float
#  ask              :float
#  open_buy_orders  :float
#  open_sell_orders :float
#  prev_day         :float
#  timestamp        :float            not null
#
# Indexes
#
#  index_bittrex_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class BittrexSnapshot < ::ApplicationRecord
  #
end
