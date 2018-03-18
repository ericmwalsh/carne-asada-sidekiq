class CreateKrakenVolumes < ActiveRecord::Migration[5.1]
  def change
    create_table :kraken_volumes, id: false do |t|
      t.string    :symbol,            null: false
      t.float     :base_volume,       null: false
      t.float     :quote_volume,      null: false
      t.float     :timestamp,         null: false

      t.index [:symbol, :timestamp], unique: true
    end
  end
end
