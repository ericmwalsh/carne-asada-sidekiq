# == Schema Information
#
# Table name: mercatox_snapshots
#
#  symbol         :string           not null
#  last           :float
#  low_24_hr      :float
#  high_24_hr     :float
#  percent_change :float
#  base_volume    :float
#  quote_volume   :float
#  lowest_ask     :float
#  highest_bid    :float
#  timestamp      :float            not null
#
# Indexes
#
#  index_mercatox_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class MercatoxSnapshot < ::ApplicationRecord
  #
end
