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

ActiveRecord::Schema.define(version: 2018_07_18_041311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "csv_files", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "match_id"
    t.bigint "player_id"
    t.bigint "venue_id"
    t.bigint "player_match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_csv_files_on_group_id"
    t.index ["match_id"], name: "index_csv_files_on_match_id"
    t.index ["player_id"], name: "index_csv_files_on_player_id"
    t.index ["player_match_id"], name: "index_csv_files_on_player_match_id"
    t.index ["venue_id"], name: "index_csv_files_on_venue_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "group_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.string "match_code"
    t.time "match_time"
    t.date "match_date"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
    t.index ["venue_id"], name: "index_matches_on_venue_id"
  end

  create_table "player_matches", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "match_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "result"
    t.index ["match_id"], name: "index_player_matches_on_match_id"
    t.index ["player_id"], name: "index_player_matches_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "player_name"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_players_on_group_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "tournament_name"
    t.string "tournament_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "venue_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "csv_files", "groups"
  add_foreign_key "csv_files", "matches"
  add_foreign_key "csv_files", "player_matches"
  add_foreign_key "csv_files", "players"
  add_foreign_key "csv_files", "venues"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "matches", "venues"
  add_foreign_key "player_matches", "matches"
  add_foreign_key "player_matches", "players"
  add_foreign_key "players", "groups"
end
