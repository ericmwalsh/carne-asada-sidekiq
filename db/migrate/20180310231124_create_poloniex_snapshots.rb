class CreatePoloniexSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :poloniex_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :last,                  null: false
      t.float         :lowest_ask,            null: false
      t.float         :highest_bid,           null: false
      t.float         :percent_change,        null: false
      t.float         :base_volume,           null: false
      t.float         :quote_volume,          null: false
      t.float         :high_24_hr,            null: false
      t.float         :low_24_hr,             null: false
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
