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

ActiveRecord::Schema.define(version: 20180406194344) do

  create_table "bills", force: :cascade do |t|
    t.date "bill_date"
    t.integer "client_id"
    t.integer "amount"
    t.float "total"
    t.integer "status"
    t.integer "perfume_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_bills_on_client_id"
    t.index ["perfume_id"], name: "index_bills_on_perfume_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "colony"
    t.integer "external_address_num"
    t.integer "internal_address_num"
    t.integer "zipcode"
    t.string "city"
    t.string "state"
  end

  create_table "order_data", force: :cascade do |t|
    t.date "order_date"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_order_data_on_client_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "amount"
    t.integer "status"
    t.float "total"
    t.integer "order_datum_id"
    t.integer "perfume_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_datum_id"], name: "index_orders_on_order_datum_id"
    t.index ["perfume_id"], name: "index_orders_on_perfume_id"
  end

  create_table "payments", force: :cascade do |t|
    t.float "amount"
    t.date "payment_date"
    t.integer "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_payments_on_bill_id"
  end

  create_table "perfumes", force: :cascade do |t|
    t.string "name"
    t.float "buy_price"
    t.float "retail_price"
    t.integer "stock"
    t.integer "public_target"
    t.integer "classification"
    t.integer "category"
    t.integer "presentation"
    t.integer "visibility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "postal_codes", force: :cascade do |t|
    t.integer "c_postal"
    t.string "settlement"
    t.string "settlement_type"
    t.string "township"
    t.string "state"
    t.string "city"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "day"
    t.time "hour"
    t.string "place"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_schedules_on_client_id"
  end

end
