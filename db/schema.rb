# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_19_125027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name_ja", limit: 500, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en", limit: 500, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "hashname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashname"], name: "index_hashtags_on_hashname", unique: true
  end

  create_table "hashtags_posts", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "hashtag_id", null: false
    t.index ["hashtag_id"], name: "index_hashtags_posts_on_hashtag_id"
    t.index ["post_id"], name: "index_hashtags_posts_on_post_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "user_id"], name: "index_likes_on_post_id_and_user_id", unique: true
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.text "image", null: false
    t.string "imageable_type", null: false
    t.bigint "imageable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "ranking_point", null: false
    t.string "eatery_name", limit: 200, null: false
    t.string "eatery_food", limit: 200, null: false
    t.string "eatery_address", limit: 500, null: false
    t.decimal "latitude", precision: 11, scale: 8
    t.decimal "longitude", precision: 11, scale: 8
    t.string "eatery_website", limit: 500, null: false
    t.text "remarks", null: false
    t.bigint "category_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["ranking_point", "category_id", "user_id"], name: "index_posts_on_ranking_point_and_category_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 500, null: false
    t.string "email", limit: 500, null: false
    t.string "password_digest", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "locale", limit: 100, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "posts", on_delete: :cascade
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "hashtags_posts", "hashtags", on_delete: :cascade
  add_foreign_key "hashtags_posts", "posts", on_delete: :cascade
  add_foreign_key "likes", "posts", on_delete: :cascade
  add_foreign_key "likes", "users", on_delete: :cascade
  add_foreign_key "posts", "categories", on_delete: :cascade
  add_foreign_key "posts", "users", on_delete: :cascade
end
