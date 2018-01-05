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

ActiveRecord::Schema.define(version: 20180104205803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fighters", force: :cascade do |t|
    t.string   "name"
    t.string   "division"
    t.string   "rank"
    t.integer  "rank_number"
    t.string   "img_url"
    t.string   "fight_record"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "is_updated"
  end

  create_table "fights", force: :cascade do |t|
    t.integer  "fighter_one_id"
    t.integer  "fighter_two_id"
    t.integer  "upvotes"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "division"
    t.string   "has_voted"
    t.integer  "red_corner_upvotes"
    t.integer  "blue_corner_upvotes"
    t.integer  "has_voted_red_corner"
    t.integer  "has_voted_blue_corner"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "fight"
    t.integer  "user"
    t.string   "upvoted"
    t.string   "red_corner"
    t.string   "blue_corner"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
