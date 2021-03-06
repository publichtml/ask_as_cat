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

ActiveRecord::Schema.define(version: 20160528095741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string   "name",       limit: 255,                 null: false
    t.boolean  "winner",                 default: false, null: false
    t.integer  "weight",                 default: 1,     null: false
    t.integer  "lottery_id",                             null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "lot_number"
    t.index ["lottery_id", "name"], name: "index_candidates_on_lottery_id_and_name", unique: true, using: :btree
  end

  create_table "lotteries", force: :cascade do |t|
    t.string   "name",          limit: 255,                 null: false
    t.integer  "winners_count"
    t.boolean  "drawn",                     default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "message_type",              default: "lt",  null: false
  end

end
