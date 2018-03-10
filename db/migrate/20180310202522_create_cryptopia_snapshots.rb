class CreateCryptopiaSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :cryptopia_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :trade_pair_id,         null: false
      t.float         :ask_price,             null: false
      t.float         :bid_price,             null: false
      t.float         :low,                   null: false
      t.float         :high,                  null: false
      t.float         :volume,                null: false
      t.float         :last_price,            null: false
      t.float         :buy_volume,            null: false
      t.float         :sell_volume,           null: false
      t.float         :change,                null: false
      t.float         :open,                  null: false
      t.float         :close,                 null: false
      t.float         :base_volume,           null: false
      t.float         :buy_base_volume,       null: false
      t.float         :sell_base_volume,      null: false
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
