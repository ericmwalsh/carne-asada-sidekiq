# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180303054041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "binance_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_binance_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "binance_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price_change", null: false
    t.float "price_change_percent", null: false
    t.float "weighted_avg_price", null: false
    t.float "high_price", null: false
    t.float "low_price", null: false
    t.float "volume", null: false
    t.float "quote_volume", null: false
    t.float "open_time", null: false
    t.float "close_time", null: false
    t.integer "first_id", null: false
    t.integer "last_id", null: false
    t.integer "count", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_binance_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "exchange", null: false
    t.string "symbol", null: false
    t.float "deleted_timestamp"
    t.index ["exchange", "deleted_timestamp"], name: "index_currencies_on_exchange_and_deleted_timestamp"
    t.index ["exchange", "symbol"], name: "index_currencies_on_exchange_and_symbol", unique: true
  end

  create_table "gdax_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gdax_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "gdax_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "sequence", null: false
    t.float "price", null: false
    t.float "open_24h", null: false
    t.float "volume_24h", null: false
    t.float "low_24h", null: false
    t.float "high_24h", null: false
    t.float "volume_30d", null: false
    t.float "best_bid", null: false
    t.float "best_ask", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gdax_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "trading_pairs", force: :cascade do |t|
    t.string "exchange", null: false
    t.string "symbol", null: false
    t.string "base_asset", null: false
    t.string "quote_asset", null: false
    t.float "deleted_timestamp"
    t.index ["exchange", "deleted_timestamp"], name: "index_trading_pairs_on_exchange_and_deleted_timestamp"
    t.index ["exchange", "symbol"], name: "index_trading_pairs_on_exchange_and_symbol", unique: true
  end

end
