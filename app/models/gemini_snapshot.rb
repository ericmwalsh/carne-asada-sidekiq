# == Schema Information
#
# Table name: gemini_snapshots
#
#  symbol       :string           not null
#  base_volume  :float            not null
#  quote_volume :float            not null
#  bid          :float            not null
#  ask          :float            not null
#  last         :float            not null
#  timestamp    :float            not null
#
# Indexes
#
#  index_gemini_snapshots_on_symbol_and_timestamp  (symbol,timestamp) UNIQUE
#

class GeminiSnapshot < ::ApplicationRecord
  #
end
