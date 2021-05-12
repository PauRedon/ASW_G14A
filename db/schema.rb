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

ActiveRecord::Schema.define(version: 2021_05_11_190304) do

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "contribucio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.index ["contribucio_id"], name: "index_comments_on_contribucio_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contribucios", force: :cascade do |t|
    t.string "tittle"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "like", default: 0
    t.string "tipus"
    t.text "texto"
    t.integer "user_id"
    t.index ["url"], name: "index_contribucios_on_url", unique: true, where: "url IS NOT NULL"
    t.index ["user_id"], name: "index_contribucios_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.string "provider"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vote_comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.index ["comment_id"], name: "index_vote_comments_on_comment_id"
    t.index ["user_id"], name: "index_vote_comments_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "contribucio_id"
    t.index ["contribucio_id"], name: "index_votes_on_contribucio_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "vote_comments", "comments"
  add_foreign_key "vote_comments", "users"
  add_foreign_key "votes", "contribucios"
  add_foreign_key "votes", "users"
end
