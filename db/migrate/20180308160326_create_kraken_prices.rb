class CreateKrakenPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :kraken_prices, id: false do |t|
      t.string  :symbol, null: false
      t.float   :price, null: false
      t.float   :timestamp, null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
