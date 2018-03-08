# == Schema Information
#
# Table name: bitstamp_snapshots
#
#  symbol    :string           not null
#  last      :float            not null
#  high      :float            not null
#  low       :float            not null
#  vwap      :float            not null
#  volume    :float            not null
#  bid       :float            not null
#  ask       :float            not null
#  open      :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_bitstamp_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class BitstampSnapshot < ::ApplicationRecord
  #
end
