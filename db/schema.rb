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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130301041204) do

  create_table "alerts", :force => true do |t|
    t.integer  "product_id"
    t.string   "alertable_type"
    t.integer  "alertable_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "alerts", ["alertable_type", "user_id"], :name => "index_alerts_on_alertable_type_and_user_id"
  add_index "alerts", ["product_id", "alertable_id"], :name => "index_alerts_on_product_id_and_alertable_id"

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "question_id"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "answers", ["user_id", "product_id", "question_id"], :name => "index_answers_on_user_id_and_product_id_and_question_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "review_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["user_id", "product_id", "review_id"], :name => "index_comments_on_user_id_and_product_id_and_review_id"

  create_table "products", :force => true do |t|
    t.string   "asin"
    t.string   "picture_url"
    t.string   "amazon_url"
    t.string   "name"
    t.integer  "price_cents"
    t.decimal  "average_rating",         :default => 0.0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.datetime "amazon_last_updated"
    t.boolean  "price_too_low"
    t.boolean  "oos",                    :default => false
    t.boolean  "reviewed_or_questioned", :default => false
    t.string   "product_group"
    t.text     "description"
    t.integer  "total_stars"
  end

  add_index "products", ["asin"], :name => "index_products_on_asin"
  add_index "products", ["reviewed_or_questioned"], :name => "index_products_on_reviewed_or_questioned"

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["user_id", "product_id"], :name => "index_questions_on_user_id_and_product_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "stars"
  end

  add_index "reviews", ["user_id", "product_id"], :name => "index_reviews_on_user_id_and_product_id"

  create_table "similars", :force => true do |t|
    t.integer  "product_id"
    t.string   "asin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "similars", ["product_id"], :name => "index_similars_on_product_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "amazon_tag"
    t.string   "name"
    t.decimal  "trust_multiplier"
    t.decimal  "amazon_tag_percent"
    t.boolean  "fb_liked"
    t.boolean  "hell"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "user_id"
    t.boolean  "voted"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_type", "votable_id", "user_id"], :name => "index_votes_on_votable_type_and_votable_id_and_user_id"

end
