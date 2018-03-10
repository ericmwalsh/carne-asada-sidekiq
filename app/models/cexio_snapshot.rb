# == Schema Information
#
# Table name: cexio_snapshots
#
#  symbol      :string           not null
#  bid         :float            not null
#  ask         :float            not null
#  low         :float            not null
#  high        :float            not null
#  last        :float            not null
#  volume      :float            not null
#  volume_30_d :float            not null
#  timestamp   :float            not null
#
# Indexes
#
#  index_cexio_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class CexioSnapshot < ::ApplicationRecord
  #
end
