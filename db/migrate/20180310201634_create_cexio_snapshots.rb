class CreateCexioSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :cexio_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :bid,                   null: false
      t.float         :ask,                   null: false
      t.float         :low,                   null: false
      t.float         :high,                  null: false
      t.float         :last,                  null: false
      t.float         :volume,                null: false
      t.float         :volume_30_d,           null: false
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
