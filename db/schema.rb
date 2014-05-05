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

ActiveRecord::Schema.define(:version => 20140505052806) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "allowed_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fusions", :force => true do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "total_working_hours"
    t.integer  "total_fusion_budget"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "kudos", :force => true do |t|
    t.integer  "value",          :default => 1
    t.text     "comment"
    t.integer  "receiver_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "weekly_kudo_id"
  end

  add_index "kudos", ["receiver_id"], :name => "index_kudos_on_receiver_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.date     "with_company_since"
    t.integer  "days_off_left",        :default => 0
    t.boolean  "retired",              :default => false
    t.integer  "default_weekly_kudos"
  end

  create_table "weekly_kudos", :force => true do |t|
    t.integer  "kudos_left",                           :default => 20
    t.integer  "last_week_kudos_received"
    t.integer  "up_to_last_week_total_kudos_received"
    t.integer  "hours_worked"
    t.integer  "user_id"
    t.integer  "week_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "trend",                                :default => "steady"
  end

  add_index "weekly_kudos", ["user_id"], :name => "index_weekly_kudos_on_user_id"
  add_index "weekly_kudos", ["week_id"], :name => "index_weekly_kudos_on_week_id"

  create_table "weeks", :force => true do |t|
    t.string   "number"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "fusion_id"
  end

  add_index "weeks", ["fusion_id"], :name => "index_weeks_on_fusion_id"

end
