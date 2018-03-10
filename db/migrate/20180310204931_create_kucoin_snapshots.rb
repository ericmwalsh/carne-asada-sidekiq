class CreateKucoinSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :kucoin_snapshots, id: false do |t|
      t.string        :symbol,                null: false
      t.float         :last_deal_price
      t.float         :buy
      t.float         :sell
      t.float         :change
      t.float         :sort
      t.float         :fee_rate
      t.float         :vol_value
      t.float         :high
      t.float         :vol
      t.float         :low
      t.float         :change_rate
      t.float         :timestamp,             null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
