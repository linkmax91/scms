# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150124140121) do

  create_table "codes", force: :cascade do |t|
    t.string   "version"
    t.text     "code"
    t.integer  "contract_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "codes", ["contract_id"], name: "index_codes_on_contract_id"

  create_table "contracts", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "parties", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "code_id"
    t.integer  "role_id"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "parties", ["code_id"], name: "index_parties_on_code_id"
  add_index "parties", ["person_id"], name: "index_parties_on_person_id"
  add_index "parties", ["role_id"], name: "index_parties_on_role_id"

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sc_events", force: :cascade do |t|
    t.text     "callback"
    t.integer  "code_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sc_events", ["code_id"], name: "index_sc_events_on_code_id"

  create_table "schedules", force: :cascade do |t|
    t.integer  "sc_event_id", null: false
    t.datetime "timestamp"
    t.string   "argument"
    t.boolean  "recurrent"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schedules", ["sc_event_id"], name: "index_schedules_on_sc_event_id"

end
