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

ActiveRecord::Schema.define(:version => 20130330105539) do

  create_table "kudos", :force => true do |t|
    t.integer  "value",       :default => 1
    t.text     "comment"
    t.integer  "giver_id"
    t.integer  "receiver_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "kudos", ["giver_id"], :name => "index_kudos_on_giver_id"
  add_index "kudos", ["receiver_id"], :name => "index_kudos_on_receiver_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.date     "with_company_since"
    t.integer  "days_off_left",      :default => 0
  end

end
