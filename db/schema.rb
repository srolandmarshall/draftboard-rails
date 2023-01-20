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

ActiveRecord::Schema[7.0].define(version: 2023_01_20_020910) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "draft_picks", force: :cascade do |t|
    t.bigint "draft_id", null: false
    t.bigint "player_id", null: false
    t.bigint "fantasy_team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pick_number"
    t.integer "round"
    t.index ["draft_id"], name: "index_draft_picks_on_draft_id"
    t.index ["fantasy_team_id"], name: "index_draft_picks_on_fantasy_team_id"
    t.index ["player_id"], name: "index_draft_picks_on_player_id"
  end

  create_table "drafts", force: :cascade do |t|
    t.string "title"
    t.datetime "scheduled_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fantasy_league_id"
    t.boolean "active"
    t.integer "current_pick", default: 1
    t.integer "roster_size"
    t.jsonb "order"
  end

  create_table "drafts_tables", force: :cascade do |t|
    t.string "title"
    t.date "scheduled_date"
    t.bigint "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_drafts_tables_on_league_id"
  end

  create_table "fantasy_leagues", force: :cascade do |t|
    t.bigint "draft_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["draft_id"], name: "index_fantasy_leagues_on_draft_id"
  end

  create_table "fantasy_teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fantasy_league_id"
    t.index ["fantasy_league_id"], name: "index_fantasy_teams_on_fantasy_league_id"
  end

  create_table "leagues_tables", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "jersey"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "data"
    t.string "url"
    t.bigint "team_id"
    t.string "full_name"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "rosters", force: :cascade do |t|
    t.bigint "fantasy_team_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fantasy_team_id"], name: "index_rosters_on_fantasy_team_id"
    t.index ["player_id"], name: "index_rosters_on_player_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "location"
    t.string "team_name"
    t.string "abbreviation"
    t.bigint "players_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["players_id"], name: "index_teams_on_players_id"
  end

  add_foreign_key "draft_picks", "drafts"
  add_foreign_key "draft_picks", "fantasy_teams"
  add_foreign_key "draft_picks", "players"
  add_foreign_key "fantasy_leagues", "drafts"
  add_foreign_key "fantasy_teams", "fantasy_leagues"
  add_foreign_key "players", "teams"
  add_foreign_key "rosters", "fantasy_teams"
  add_foreign_key "rosters", "players"
  add_foreign_key "teams", "players", column: "players_id"
end
