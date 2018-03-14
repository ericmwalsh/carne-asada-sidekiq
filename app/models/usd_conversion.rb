# == Schema Information
#
# Table name: usd_conversions
#
#  aud       :float
#  cad       :float
#  cny       :float
#  eur       :float
#  gbp       :float
#  jpy       :float
#  krw       :float
#  nzd       :float
#  rub       :float
#  timestamp :float            not null
#
# Indexes
#
#  index_usd_conversions_on_timestamp  (timestamp) UNIQUE
#

class UsdConversion < ::ApplicationRecord
  #
end
