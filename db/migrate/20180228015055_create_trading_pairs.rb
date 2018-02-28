class CreateTradingPairs < ActiveRecord::Migration[5.1]
  def change
    create_table :trading_pairs do |t|
      t.string      :exchange,          null: false
      t.string      :symbol,            null: false
      t.string      :base_asset,        null: false
      t.string      :quote_asset,       null: false
      t.float       :deleted_timestamp

      t.index [:exchange, :symbol],     unique: true
      t.index [:exchange, :deleted_timestamp]
    end
  end
end
