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

ActiveRecord::Schema.define(version: 2018_12_06_191927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoption_requests", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "telephone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "animal_id"
    t.index ["animal_id"], name: "index_adoption_requests_on_animal_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "medical_condition"
    t.string "temp_name"
    t.string "race"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shelter_id"
    t.bigint "adoption_request_id"
    t.boolean "pending_adoption", default: false
    t.string "shelter_name"
    t.index ["adoption_request_id"], name: "index_animals_on_adoption_request_id"
    t.index ["shelter_id"], name: "index_animals_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "role"
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shelter_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["shelter_id"], name: "index_users_on_shelter_id"
  end

end
