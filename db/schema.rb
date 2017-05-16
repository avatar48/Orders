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

ActiveRecord::Schema.define(version: 20170512064837) do

  create_table "invoice_line_items", force: :cascade do |t|
    t.string   "product_name"
    t.string   "product_code"
    t.integer  "quantity"
    t.decimal  "price",        precision: 8, scale: 2
    t.string   "unit"
    t.string   "partner_code"
    t.integer  "invoice_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["invoice_id"], name: "index_invoice_line_items_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "number"
    t.date     "date"
    t.decimal  "sum",                   precision: 8, scale: 2
    t.string   "seller_inn", limit: 10
    t.string   "saler_kpp",  limit: 10
    t.string   "buyer_inn",  limit: 10
    t.string   "buyer_kpp",  limit: 10
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "number"
    t.boolean  "sent"
    t.date     "date"
    t.decimal  "sum",                   precision: 8, scale: 2
    t.integer  "inn",        limit: 10
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "stocks_line_items", force: :cascade do |t|
    t.string   "product_name"
    t.string   "unit"
    t.integer  "quantity"
    t.decimal  "price",        precision: 8, scale: 2
    t.integer  "code_contr"
    t.integer  "stock_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["stock_id"], name: "index_stocks_line_items_on_stock_id"
  end

end
