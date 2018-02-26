class CreateBinancePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :binance_prices, id: false do |t|
      t.string  :symbol
      t.float   :price
      t.float   :timestamp
    end
  end
end
