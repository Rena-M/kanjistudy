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

ActiveRecord::Schema.define(version: 20170313015527) do

  create_table "kanji_letters", force: :cascade do |t|
    t.integer  "kanji_id",   limit: 4
    t.integer  "letter_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "kanji_letters", ["kanji_id"], name: "index_kanji_letters_on_kanji_id", using: :btree
  add_index "kanji_letters", ["letter_id"], name: "index_kanji_letters_on_letter_id", using: :btree

  create_table "kanjis", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "word",          limit: 255
    t.string   "meaning",       limit: 255
    t.string   "pronunciation", limit: 255
    t.text     "comment",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "image",         limit: 255
  end

  create_table "letters", force: :cascade do |t|
    t.string   "letter",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "meanings", force: :cascade do |t|
    t.string   "meaning",    limit: 255
    t.integer  "letter_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pronunciations", force: :cascade do |t|
    t.string   "ja",         limit: 255
    t.string   "en",         limit: 255
    t.integer  "letter_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "kanji_letters", "kanjis"
  add_foreign_key "kanji_letters", "letters"
end
