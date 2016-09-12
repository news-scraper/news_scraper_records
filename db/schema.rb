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

ActiveRecord::Schema.define(version: 20160909021628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "news_articles", force: :cascade do |t|
    t.string   "author"
    t.text     "body"
    t.text     "description"
    t.text     "keywords"
    t.string   "section"
    t.datetime "datetime"
    t.string   "title"
    t.string   "root_domain"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "uri"
    t.index ["author"], name: "index_news_articles_on_author", using: :btree
    t.index ["datetime"], name: "index_news_articles_on_datetime", using: :btree
    t.index ["root_domain"], name: "index_news_articles_on_root_domain", using: :btree
    t.index ["title"], name: "index_news_articles_on_title", using: :btree
    t.index ["uri"], name: "index_news_articles_on_uri", unique: true, using: :btree
  end

  create_table "training_logs", force: :cascade do |t|
    t.string   "root_domain"
    t.text     "uris",           default: [],              array: true
    t.integer  "trained_status", default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["root_domain", "trained_status"], name: "index_training_logs_on_root_domain_and_trained_status", using: :btree
    t.index ["root_domain"], name: "index_training_logs_on_root_domain", using: :btree
    t.index ["trained_status"], name: "index_training_logs_on_trained_status", using: :btree
  end

end
