# == Schema Information
#
# Table name: trading_pairs
#
#  id                :integer          not null, primary key
#  exchange          :string           not null
#  symbol            :string           not null
#  base_asset        :string           not null
#  quote_asset       :string           not null
#  deleted_timestamp :float
#
# Indexes
#
#  index_trading_pairs_on_exchange_and_deleted_timestamp  (exchange,deleted_timestamp)
#  index_trading_pairs_on_exchange_and_symbol             (exchange,symbol) UNIQUE
#

class TradingPair < ::ApplicationRecord
  #
end
