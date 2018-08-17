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

ActiveRecord::Schema.define(version: 20180817153935) do

  create_table "dramas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.string "site", null: false
    t.integer "latest_episode", default: 0
    t.timestamp "latest_episode_update"
    t.string "link", null: false
    t.string "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "site"], name: "index_on_title_and_site"
  end

  create_table "user_dramas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "drama_id", null: false
    t.integer "episode_number", null: false
    t.integer "episode_length", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drama_id"], name: "index_user_dramas_on_drama_id"
    t.index ["user_id", "drama_id", "episode_number"], name: "index_on_user_and_drama_and_episode"
    t.index ["user_id", "drama_id"], name: "index_on_user_and_drama"
    t.index ["user_id"], name: "index_user_dramas_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_users_on_key", unique: true
  end

  add_foreign_key "user_dramas", "dramas"
  add_foreign_key "user_dramas", "users"
end
