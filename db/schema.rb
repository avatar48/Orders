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

ActiveRecord::Schema.define(version: 20170507141225) do

  create_table "documents", force: :cascade do |t|
    t.string   "number"
    t.date     "date"
    t.decimal  "sum",                   precision: 8, scale: 2
    t.integer  "inn",        limit: 10
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "files_ins", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_line_items", force: :cascade do |t|
    t.string   "product_name"
    t.string   "product_code"
    t.integer  "quantity"
    t.decimal  "price",        precision: 8, scale: 2
    t.string   "unit"
    t.integer  "partner_code"
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

  create_table "lineitems", force: :cascade do |t|
    t.string   "product_name"
    t.integer  "quantity"
    t.decimal  "price",        precision: 8, scale: 2
    t.string   "unit"
    t.integer  "code_contr"
    t.integer  "document_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["document_id"], name: "index_lineitems_on_document_id"
  end

end
