class CreateTradingPairPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :trading_pair_prices, id: false do |t|
      t.string      :exchange,          null: false
      t.string      :symbol,            null: false
      t.float       :timestamp,         null: false
      t.float       :price_usd,         null: false

      t.index [:exchange, :symbol, :timestamp], unique: true
    end
  end
end
