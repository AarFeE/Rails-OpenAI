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

ActiveRecord::Schema[7.2].define(version: 2024_12_10_001803) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "machine_state", ["AVAILABLE", "RENTED"]
  create_enum "rent_state", ["ACTIVE", "INOPERATIVE"]

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "name", limit: 175, null: false
    t.string "email", limit: 250, null: false
    t.integer "phone", null: false
    t.text "address", null: false

    t.unique_constraint ["email"], name: "unique_email"
    t.unique_constraint ["phone"], name: "unique_phone"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "processed_in_job"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "machines", id: :serial, force: :cascade do |t|
    t.string "model", limit: 250, null: false
    t.string "series_number", limit: 250, null: false
    t.enum "state", default: "AVAILABLE", enum_type: "machine_state"

    t.unique_constraint ["series_number"], name: "unique_series_number"
  end

  create_table "rents", id: :serial, force: :cascade do |t|
    t.integer "id_client", null: false
    t.integer "id_machine", null: false
    t.date "beginning_date", null: false
    t.date "ending_date", null: false
    t.enum "state", default: "ACTIVE", enum_type: "rent_state"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.text "ai_response"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_responses_on_form_id"
  end

  add_foreign_key "rents", "clients", column: "id_client", name: "rents_id_client_fkey"
  add_foreign_key "rents", "machines", column: "id_machine", name: "rents_id_machine_fkey"
  add_foreign_key "responses", "forms"
end
