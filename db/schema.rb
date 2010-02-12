# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100212221845) do

  create_table "business_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", :force => true do |t|
    t.string   "name",                                               :null => false
    t.integer  "business_type_id"
    t.string   "contact_name"
    t.string   "contact_department"
    t.string   "contact_email"
    t.string   "street",                                             :null => false
    t.string   "street2"
    t.string   "city",                                               :null => false
    t.string   "state",                                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "responded_at"
    t.boolean  "mailing_required",                 :default => true
    t.integer  "phone",              :limit => 10
    t.integer  "phone_ext"
    t.integer  "contact_phone",      :limit => 10
    t.integer  "contact_phone_ext"
    t.integer  "zip",                :limit => 9
  end

  create_table "contributions", :force => true do |t|
    t.integer  "business_id",                       :null => false
    t.string   "nature",                            :null => false
    t.decimal  "value",            :default => 0.0, :null => false
    t.text     "message"
    t.integer  "delivery_method",                   :null => false
    t.text     "delivery_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "received_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
