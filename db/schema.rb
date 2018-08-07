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

ActiveRecord::Schema.define(version: 2018_08_07_233146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_listings", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.string "colour"
    t.integer "year"
    t.string "reference"
    t.string "url"
    t.bigint "enquiry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enquiry_id"], name: "index_car_listings_on_enquiry_id"
  end

  create_table "enquiries", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "message"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_enquiries_on_source_id"
  end

  create_table "websites", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "car_listings", "enquiries"
  add_foreign_key "enquiries", "websites", column: "source_id"
end
