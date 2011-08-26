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

ActiveRecord::Schema.define(:version => 20110825022920) do

  create_table "stations", :force => true do |t|
    t.integer  "cta_id"
    t.string   "name"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stops", :force => true do |t|
    t.integer  "cta_id"
    t.string   "name"
    t.string   "direction"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "station_name"
    t.integer  "station_cta_id"
    t.boolean  "ada"
    t.boolean  "red"
    t.boolean  "blue"
    t.boolean  "green"
    t.boolean  "brown"
    t.boolean  "purple"
    t.boolean  "purple_express"
    t.boolean  "yellow"
    t.boolean  "pink"
    t.boolean  "orange"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
