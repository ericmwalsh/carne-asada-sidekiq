class CreateUsdConversions < ActiveRecord::Migration[5.1]
  def change
    create_table :usd_conversions, id: false do |t|
      t.float       :aud
      t.float       :cad
      t.float       :cny
      t.float       :eur
      t.float       :gbp
      t.float       :jpy
      t.float       :krw
      t.float       :nzd
      t.float       :rub
      t.float       :timestamp,     null: false

      t.index       :timestamp,     unique: true
    end
  end
end
