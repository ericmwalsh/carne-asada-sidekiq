class CreateCurrencyPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_prices, id: false do |t|
      t.string      :symbol,            null: false
      t.float       :timestamp,         null: false
      t.float       :price_usd,         null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
