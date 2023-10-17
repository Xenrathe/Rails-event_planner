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

ActiveRecord::Schema[7.0].define(version: 2023_10_17_010024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventure_attendances", force: :cascade do |t|
    t.bigint "adventure_attendee_id"
    t.bigint "attended_adventure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adventure_attendee_id"], name: "index_adventure_attendances_on_adventure_attendee_id"
    t.index ["attended_adventure_id"], name: "index_adventure_attendances_on_attended_adventure_id"
  end

  create_table "adventures", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id", null: false
    t.integer "event_type"
    t.index ["creator_id"], name: "index_adventures_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "adventure_attendances", "adventures", column: "attended_adventure_id"
  add_foreign_key "adventure_attendances", "users", column: "adventure_attendee_id"
  add_foreign_key "adventures", "users", column: "creator_id"
end