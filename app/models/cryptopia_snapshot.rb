# == Schema Information
#
# Table name: cryptopia_snapshots
#
#  symbol           :string           not null
#  trade_pair_id    :float            not null
#  ask_price        :float            not null
#  bid_price        :float            not null
#  low              :float            not null
#  high             :float            not null
#  volume           :float            not null
#  last_price       :float            not null
#  buy_volume       :float            not null
#  sell_volume      :float            not null
#  change           :float            not null
#  open             :float            not null
#  close            :float            not null
#  base_volume      :float            not null
#  buy_base_volume  :float            not null
#  sell_base_volume :float            not null
#  timestamp        :float            not null
#
# Indexes
#
#  index_cryptopia_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class CryptopiaSnapshot < ::ApplicationRecord
  #
end
