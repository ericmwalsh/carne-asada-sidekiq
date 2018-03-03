class CreateGdaxSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :gdax_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :sequence,              null: false
      t.float         :price,                 null: false
      t.float         :open_24h,              null: false
      t.float         :volume_24h,            null: false
      t.float         :low_24h,               null: false
      t.float         :high_24h,              null: false
      t.float         :volume_30d,            null: false
      t.float         :best_bid,              null: false
      t.float         :best_ask,              null: false
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
