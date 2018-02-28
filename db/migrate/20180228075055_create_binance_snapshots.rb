class CreateBinanceSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :binance_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :price_change,          null: false
      t.float         :price_change_percent,  null: false
      t.float         :weighted_avg_price,    null: false
      t.float         :high_price,            null: false
      t.float         :low_price,             null: false
      t.float         :volume,                null: false
      t.float         :quote_volume,          null: false
      t.float         :open_time,             null: false
      t.float         :close_time,            null: false
      t.integer       :first_id,              null: false
      t.integer       :last_id,               null: false
      t.integer       :count,                 null: false
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
