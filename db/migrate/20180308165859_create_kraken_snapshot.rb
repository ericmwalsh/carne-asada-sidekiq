class CreateKrakenSnapshot < ActiveRecord::Migration[5.1]
  def change
    create_table :kraken_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :ask_price,             null: false
      t.float         :ask_whole_lot_volume,  null: false
      t.float         :ask_lot_volume,        null: false
      t.float         :bid_price,             null: false
      t.float         :bid_whole_lot_volume,  null: false
      t.float         :bid_lot_volume,        null: false
      t.float         :last_price,            null: false
      t.float         :last_lot_volume,       null: false
      t.float         :volume_today,          null: false
      t.float         :volume_last_24h,       null: false
      t.float         :vwap_today,            null: false
      t.float         :vwap_last_24h,         null: false
      t.float         :trades_today,          null: false
      t.float         :trades_last_24h,       null: false
      t.float         :low_today,             null: false
      t.float         :low_last_24h,          null: false
      t.float         :high_today,            null: false
      t.float         :high_last_24h,         null: false
      t.float         :open,                  null: false
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
