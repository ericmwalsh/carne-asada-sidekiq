# == Schema Information
#
# Table name: currencies
#
#  id                :integer          not null, primary key
#  exchange          :string           not null
#  symbol            :string           not null
#  deleted_timestamp :float
#
# Indexes
#
#  index_currencies_on_exchange_and_deleted_timestamp  (exchange,deleted_timestamp)
#  index_currencies_on_exchange_and_symbol             (exchange,symbol) UNIQUE
#

class Currency < ::ApplicationRecord
  #
end
