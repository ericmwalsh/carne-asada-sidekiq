class RemoveNonNullConstraintsFromBittrexSnapshots < ActiveRecord::Migration[5.1]
  def up
    change_column :bittrex_snapshots, :high, :string, null: true
    change_column :bittrex_snapshots, :low, :float, null: true
    change_column :bittrex_snapshots, :volume, :float, null: true
    change_column :bittrex_snapshots, :last, :float, null: true
    change_column :bittrex_snapshots, :base_volume, :float, null: true
    change_column :bittrex_snapshots, :bid, :float, null: true
    change_column :bittrex_snapshots, :ask, :float, null: true
    change_column :bittrex_snapshots, :open_buy_orders, :float, null: true
    change_column :bittrex_snapshots, :open_sell_orders, :float, null: true
    change_column :bittrex_snapshots, :prev_day, :float, null: true
  end

  def down
    change_column :bittrex_snapshots, :high, :string, null: false
    change_column :bittrex_snapshots, :low, :float, null: false
    change_column :bittrex_snapshots, :volume, :float, null: false
    change_column :bittrex_snapshots, :last, :float, null: false
    change_column :bittrex_snapshots, :base_volume, :float, null: false
    change_column :bittrex_snapshots, :bid, :float, null: false
    change_column :bittrex_snapshots, :ask, :float, null: false
    change_column :bittrex_snapshots, :open_buy_orders, :float, null: false
    change_column :bittrex_snapshots, :open_sell_orders, :float, null: false
    change_column :bittrex_snapshots, :prev_day, :float, null: false
  end
end
