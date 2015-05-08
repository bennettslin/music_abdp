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

ActiveRecord::Schema.define(version: 20150507180043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quizzes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "result"
  end

  add_index "quizzes", ["song_id"], name: "index_quizzes_on_song_id", using: :btree
  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "itunes_id"
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.integer  "year"
    t.string   "primary_genre"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "songs_users", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "songs_users", ["song_id"], name: "index_songs_users_on_song_id", using: :btree
  add_index "songs_users", ["user_id"], name: "index_songs_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_hash"
    t.integer  "genre_preference"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "code"
    t.datetime "expires_at"
  end

  add_foreign_key "quizzes", "songs"
  add_foreign_key "quizzes", "users"
  add_foreign_key "songs_users", "songs"
  add_foreign_key "songs_users", "users"
end
