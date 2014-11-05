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

ActiveRecord::Schema.define(version: 20141105023728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "commenter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  create_table "email_confirmers", force: true do |t|
    t.integer "user_id"
    t.string  "confirmation_token"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "rant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interesting_ranters", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rants", force: true do |t|
    t.string   "topic"
    t.text     "details"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shown",      default: true
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.string   "rant_frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.boolean  "is_admin",           default: false
    t.boolean  "is_disabled",        default: false
    t.string   "email"
    t.boolean  "email_is_confirmed", default: false
    t.string   "avatar"
  end

end
