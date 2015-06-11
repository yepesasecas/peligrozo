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

ActiveRecord::Schema.define(version: 20150408162644) do

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "country_movies", force: true do |t|
    t.integer  "movie_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "country_theaters", force: true do |t|
    t.integer  "country_id"
    t.integer  "theater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "country_users", force: true do |t|
    t.integer  "country_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eliminated_movies", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tmdb_id"
  end

  add_index "eliminated_movies", ["movie_id"], name: "index_eliminated_movies_on_movie_id"
  add_index "eliminated_movies", ["tmdb_id"], name: "index_eliminated_movies_on_tmdb_id"
  add_index "eliminated_movies", ["user_id"], name: "index_eliminated_movies_on_user_id"

  create_table "favorite_genres", force: true do |t|
    t.integer  "user_id"
    t.integer  "genre_id"
    t.integer  "interest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_genres", ["genre_id"], name: "index_favorite_genres_on_genre_id"
  add_index "favorite_genres", ["user_id"], name: "index_favorite_genres_on_user_id"

  create_table "favorite_movies", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen",       default: false
    t.text     "review"
    t.integer  "stars"
  end

  add_index "favorite_movies", ["movie_id"], name: "index_favorite_movies_on_movie_id"
  add_index "favorite_movies", ["seen"], name: "index_favorite_movies_on_seen"
  add_index "favorite_movies", ["user_id"], name: "index_favorite_movies_on_user_id"

  create_table "favorite_theaters", force: true do |t|
    t.integer  "theater_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_theaters", ["theater_id"], name: "index_favorite_theaters_on_theater_id"
  add_index "favorite_theaters", ["user_id"], name: "index_favorite_theaters_on_user_id"

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.integer  "tmdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres", ["id"], name: "index_genres_on_id"
  add_index "genres", ["name"], name: "index_genres_on_name"
  add_index "genres", ["tmdb_id"], name: "index_genres_on_tmdb_id"

  create_table "movie_genres", force: true do |t|
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_genres", ["genre_id"], name: "index_movie_genres_on_genre_id"
  add_index "movie_genres", ["movie_id"], name: "index_movie_genres_on_movie_id"

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.text     "overview"
    t.string   "poster_path"
    t.date     "release_date"
    t.integer  "tmdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "trailer"
  end

  add_index "movies", ["id"], name: "index_movies_on_id"
  add_index "movies", ["name"], name: "index_movies_on_name"
  add_index "movies", ["state"], name: "index_movies_on_state"
  add_index "movies", ["tmdb_id"], name: "index_movies_on_tmdb_id"
  add_index "movies", ["value"], name: "index_movies_on_value"

  create_table "schedules", force: true do |t|
    t.integer  "movie_id"
    t.integer  "theater_id"
    t.text     "description"
    t.string   "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["id"], name: "index_schedules_on_id"
  add_index "schedules", ["movie_id"], name: "index_schedules_on_movie_id"
  add_index "schedules", ["theater_id"], name: "index_schedules_on_theater_id"

  create_table "theaters", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "facebook"
    t.string   "twitter"
    t.integer  "city_id"
  end

  add_index "theaters", ["id"], name: "index_theaters_on_id"
  add_index "theaters", ["name"], name: "index_theaters_on_name"

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
    t.string   "email"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["id"], name: "index_users_on_id"
  add_index "users", ["uid"], name: "index_users_on_uid"

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
