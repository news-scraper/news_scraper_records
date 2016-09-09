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

ActiveRecord::Schema.define(version: 20160909002009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "news_scrapers", force: :cascade do |t|
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
    t.index ["author"], name: "index_news_scrapers_on_author", using: :btree
    t.index ["datetime"], name: "index_news_scrapers_on_datetime", using: :btree
    t.index ["root_domain"], name: "index_news_scrapers_on_root_domain", using: :btree
    t.index ["title"], name: "index_news_scrapers_on_title", using: :btree
    t.index ["uri"], name: "index_news_scrapers_on_uri", unique: true, using: :btree
  end

end
