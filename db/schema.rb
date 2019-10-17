# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_12_133136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.string "phone"
    t.string "email"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_addresses_on_order_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.decimal "unit_price"
    t.integer "quantity"
    t.bigint "order_id", null: false
    t.string "event_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["ticket_id"], name: "index_line_items_on_ticket_id"
  end

  create_table "order_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.text "metadata", default: "{}"
    t.integer "sort_key", null: false
    t.integer "order_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id", "most_recent"], name: "index_order_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["order_id", "sort_key"], name: "index_order_transitions_parent_sort", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.text "comment"
    t.bigint "shipping_type_id", null: false
    t.decimal "shipping_cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipping_type_id"], name: "index_orders_on_shipping_type_id"
  end

  create_table "shipping_types", force: :cascade do |t|
    t.string "name"
    t.decimal "cost"
    t.integer "delivery_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "available"
    t.bigint "ticket_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_id"], name: "index_stocks_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "kind"
    t.decimal "price"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  add_foreign_key "addresses", "orders"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "tickets"
  add_foreign_key "order_transitions", "orders"
  add_foreign_key "orders", "shipping_types"
  add_foreign_key "stocks", "tickets"
  add_foreign_key "tickets", "events"
end
