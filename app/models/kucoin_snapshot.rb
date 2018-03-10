# == Schema Information
#
# Table name: kucoin_snapshots
#
#  symbol          :string           not null
#  last_deal_price :float
#  buy             :float
#  sell            :float
#  change          :float
#  sort            :float
#  fee_rate        :float
#  vol_value       :float
#  high            :float
#  vol             :float
#  low             :float
#  change_rate     :float
#  timestamp       :float            not null
#
# Indexes
#
#  index_kucoin_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class KucoinSnapshot < ::ApplicationRecord
  #
end
