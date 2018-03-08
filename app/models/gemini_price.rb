# == Schema Information
#
# Table name: gemini_prices
#
#  symbol    :string           not null
#  price     :float            not null
#  timestamp :float            not null
#
# Indexes
#
#  index_gemini_prices_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class GeminiPrice < ::ApplicationRecord
  #
end
