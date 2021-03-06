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

ActiveRecord::Schema.define(:version => 20141205182748) do

  create_table "clients", :force => true do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "prod_return_id"
    t.text     "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "prattachments", :force => true do |t|
    t.integer  "prod_return_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "pr_file_file_name"
    t.string   "pr_file_content_type"
    t.integer  "pr_file_file_size"
    t.datetime "pr_file_updated_at"
  end

  create_table "prod_returns", :force => true do |t|
    t.integer  "user_id"
    t.string   "client_name"
    t.text     "client_msg"
    t.string   "auction_name"
    t.date     "auction_date"
    t.integer  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.decimal  "purchase_net_euro",  :precision => 10, :scale => 3
    t.decimal  "buy_now_gross",      :precision => 10, :scale => 3
    t.decimal  "delivery_cost",      :precision => 10, :scale => 3
    t.decimal  "delivery_dhl_gross", :precision => 10, :scale => 3
  end

  create_table "sales", :force => true do |t|
    t.string   "title"
    t.decimal  "price"
    t.integer  "quantity"
    t.integer  "status"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
