class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string      :exchange,          null: false
      t.string      :symbol,            null: false
      t.float       :deleted_timestamp

      t.index [:exchange, :symbol],     unique: true
      t.index [:exchange, :deleted_timestamp]
    end
  end
end
