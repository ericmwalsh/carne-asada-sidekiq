class AddNonNullConstraintAndIndexesToBinancePrices < ActiveRecord::Migration[5.1]
  def up
    change_column :binance_prices, :symbol, :string, null: false
    change_column :binance_prices, :price, :float, null: false
    change_column :binance_prices, :timestamp, :float, null: false
    add_index(
      :binance_prices,
      [
        :symbol,
        :timestamp
      ],
      unique: true
    )
    remove_index(
      :binance_prices,
      :symbol
    )
  end

  def down
    change_column :binance_prices, :symbol, :string, null: true
    change_column :binance_prices, :price, :float, null: true
    change_column :binance_prices, :timestamp, :float, null: true
    remove_index(
      :binance_prices,
      [
        :symbol,
        :timestamp
      ]
    )
    add_index(
      :binance_prices,
      :symbol
    )
  end
end
