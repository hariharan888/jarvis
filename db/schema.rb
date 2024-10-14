# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_27_065505) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "noticed_events", force: :cascade do |t|
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.jsonb "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
  end

  create_table "stock_infos", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.decimal "pe_ratio"
    t.decimal "pb_ratio"
    t.decimal "market_cap"
    t.string "sector"
    t.decimal "dividend_yield"
    t.decimal "eps"
    t.decimal "roce"
    t.decimal "roe"
    t.decimal "debt_to_equity"
    t.decimal "book_value"
    t.decimal "face_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_stock_infos_on_stock_id"
  end

  create_table "stock_prices", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.date "date", null: false
    t.decimal "open", null: false
    t.decimal "high", null: false
    t.decimal "low", null: false
    t.decimal "close", null: false
    t.integer "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_stock_prices_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name", null: false
    t.string "ticker", null: false
    t.string "exchange", null: false
    t.string "isin", null: false
    t.string "company_name", null: false
    t.integer "bse_code"
    t.string "nse_code"
    t.string "sector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "jti"
    t.datetime "discarded_at"
    t.string "secondary_token"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["secondary_token"], name: "index_users_on_secondary_token", unique: true
  end

  add_foreign_key "stock_infos", "stocks"
  add_foreign_key "stock_prices", "stocks"
end
