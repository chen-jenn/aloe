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

ActiveRecord::Schema.define(version: 20180423021139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "common_names", force: :cascade do |t|
    t.text "name"
    t.bigint "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_common_names_on_plant_id"
  end

  create_table "countries", force: :cascade do |t|
    t.text "country_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.text "description"
    t.bigint "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.index ["plant_id"], name: "index_images_on_plant_id"
  end

  create_table "plant_countries", force: :cascade do |t|
    t.bigint "plant_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_plant_countries_on_country_id"
    t.index ["plant_id"], name: "index_plant_countries_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.text "species_name"
    t.string "city"
    t.text "climate_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.string "country"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "common_names", "plants"
  add_foreign_key "images", "plants"
  add_foreign_key "plant_countries", "countries"
  add_foreign_key "plant_countries", "plants"
end
