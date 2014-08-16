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

ActiveRecord::Schema.define(version: 20140816172150) do

  create_table "favorite_genres", force: true do |t|
    t.integer  "user_id"
    t.integer  "genre_id"
    t.integer  "interest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_theaters", force: true do |t|
    t.integer  "theater_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.integer  "tmdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.text     "overview"
    t.string   "poster_path"
    t.date     "release_date"
    t.integer  "tmdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "trailer"
  end

  create_table "schedules", force: true do |t|
    t.integer  "movie_id"
    t.integer  "theater_id"
    t.string   "description"
    t.string   "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theaters", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "first_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

end
