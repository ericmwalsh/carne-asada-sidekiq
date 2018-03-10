# == Schema Information
#
# Table name: gateio_snapshots
#
#  symbol         :string           not null
#  last           :float            not null
#  lowest_ask     :float            not null
#  highest_bid    :float            not null
#  percent_change :float            not null
#  base_volume    :float            not null
#  quote_volume   :float            not null
#  high_24_hr     :float            not null
#  low_24_hr      :float            not null
#  timestamp      :float            not null
#
# Indexes
#
#  index_gateio_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class GateioSnapshot < ::ApplicationRecord
  #
end
