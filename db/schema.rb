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

ActiveRecord::Schema.define(version: 20180320032431) do

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

  create_table "binance_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_binance_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "bitstamp_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_bitstamp_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "bitstamp_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "last", null: false
    t.float "high", null: false
    t.float "low", null: false
    t.float "vwap", null: false
    t.float "volume", null: false
    t.float "bid", null: false
    t.float "ask", null: false
    t.float "open", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_bitstamp_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "bitstamp_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_bitstamp_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "bittrex_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_bittrex_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "bittrex_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.string "high"
    t.float "low"
    t.float "volume"
    t.float "last"
    t.float "base_volume"
    t.float "bid"
    t.float "ask"
    t.float "open_buy_orders"
    t.float "open_sell_orders"
    t.float "prev_day"
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_bittrex_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "bittrex_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_bittrex_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "cexio_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_cexio_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "cexio_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "bid", null: false
    t.float "ask", null: false
    t.float "low", null: false
    t.float "high", null: false
    t.float "last", null: false
    t.float "volume", null: false
    t.float "volume_30_d", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_cexio_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "cexio_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_cexio_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "cryptopia_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_cryptopia_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "cryptopia_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "trade_pair_id", null: false
    t.float "ask_price", null: false
    t.float "bid_price", null: false
    t.float "low", null: false
    t.float "high", null: false
    t.float "volume", null: false
    t.float "last_price", null: false
    t.float "buy_volume", null: false
    t.float "sell_volume", null: false
    t.float "change", null: false
    t.float "open", null: false
    t.float "close", null: false
    t.float "base_volume", null: false
    t.float "buy_base_volume", null: false
    t.float "sell_base_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_cryptopia_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "cryptopia_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_cryptopia_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "exchange", null: false
    t.string "symbol", null: false
    t.float "deleted_timestamp"
    t.index ["exchange", "deleted_timestamp"], name: "index_currencies_on_exchange_and_deleted_timestamp"
    t.index ["exchange", "symbol"], name: "index_currencies_on_exchange_and_symbol", unique: true
  end

  create_table "gateio_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gateio_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "gateio_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "last", null: false
    t.float "lowest_ask", null: false
    t.float "highest_bid", null: false
    t.float "percent_change", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "high_24_hr", null: false
    t.float "low_24_hr", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gateio_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "gateio_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gateio_volumes_on_symbol_and_timestamp", unique: true
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

  create_table "gdax_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gdax_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "gemini_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gemini_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "gemini_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "bid", null: false
    t.float "ask", null: false
    t.float "last", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gemini_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "gemini_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_gemini_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "kraken_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_kraken_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "kraken_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "ask_price", null: false
    t.float "ask_whole_lot_volume", null: false
    t.float "ask_lot_volume", null: false
    t.float "bid_price", null: false
    t.float "bid_whole_lot_volume", null: false
    t.float "bid_lot_volume", null: false
    t.float "last_price", null: false
    t.float "last_lot_volume", null: false
    t.float "volume_today", null: false
    t.float "volume_last_24h", null: false
    t.float "vwap_today", null: false
    t.float "vwap_last_24h", null: false
    t.float "trades_today", null: false
    t.float "trades_last_24h", null: false
    t.float "low_today", null: false
    t.float "low_last_24h", null: false
    t.float "high_today", null: false
    t.float "high_last_24h", null: false
    t.float "open", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_kraken_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "kraken_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_kraken_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "kucoin_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_kucoin_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "kucoin_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "last_deal_price"
    t.float "buy"
    t.float "sell"
    t.float "change"
    t.float "sort"
    t.float "fee_rate"
    t.float "vol_value"
    t.float "high"
    t.float "vol"
    t.float "low"
    t.float "change_rate"
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_kucoin_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "kucoin_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_kucoin_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "mercatox_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_mercatox_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "mercatox_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "last"
    t.float "low_24_hr"
    t.float "high_24_hr"
    t.float "percent_change"
    t.float "base_volume"
    t.float "quote_volume"
    t.float "lowest_ask"
    t.float "highest_bid"
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_mercatox_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "mercatox_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_mercatox_volumes_on_symbol_and_timestamp", unique: true
  end

  create_table "poloniex_prices", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "price", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_poloniex_prices_on_symbol_and_timestamp", unique: true
  end

  create_table "poloniex_snapshots", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "last", null: false
    t.float "lowest_ask", null: false
    t.float "highest_bid", null: false
    t.float "percent_change", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "high_24_hr", null: false
    t.float "low_24_hr", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_poloniex_snapshots_on_symbol_and_timestamp", unique: true
  end

  create_table "poloniex_volumes", id: false, force: :cascade do |t|
    t.string "symbol", null: false
    t.float "base_volume", null: false
    t.float "quote_volume", null: false
    t.float "timestamp", null: false
    t.index ["symbol", "timestamp"], name: "index_poloniex_volumes_on_symbol_and_timestamp", unique: true
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

  create_table "usd_conversions", id: false, force: :cascade do |t|
    t.float "aud"
    t.float "cad"
    t.float "cny"
    t.float "eur"
    t.float "gbp"
    t.float "jpy"
    t.float "krw"
    t.float "nzd"
    t.float "rub"
    t.float "timestamp", null: false
    t.index ["timestamp"], name: "index_usd_conversions_on_timestamp", unique: true
  end

end
