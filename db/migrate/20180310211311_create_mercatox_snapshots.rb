class CreateMercatoxSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :mercatox_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :last
      t.float         :low_24_hr
      t.float         :high_24_hr
      t.float         :percent_change
      t.float         :base_volume
      t.float         :quote_volume
      t.float         :lowest_ask
      t.float         :highest_bid
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
