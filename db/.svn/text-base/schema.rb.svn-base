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

ActiveRecord::Schema.define(:version => 20121108191623) do

  create_table "ads_points", :force => true do |t|
    t.string   "title"
    t.float    "lat"
    t.float    "lng"
    t.integer  "campus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads_points_contests", :id => false, :force => true do |t|
    t.integer "contest_id"
    t.integer "ads_point_id"
  end

  create_table "ads_points_events", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "ads_point_id"
  end

  create_table "answers", :force => true do |t|
    t.string   "user_id"
    t.integer  "survey_id"
    t.integer  "question_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group"
  end

  create_table "buildings", :force => true do |t|
    t.integer  "floors"
    t.integer  "poi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus", :force => true do |t|
    t.string   "name"
    t.string   "lat"
    t.string   "lng"
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "contests", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "init_date"
    t.datetime "end_date"
    t.string   "organizer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "initials"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.float    "lat",                :limit => 255
    t.float    "lng",                :limit => 255
    t.integer  "campus_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.datetime "init_date"
    t.datetime "end_date"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "indoor_maps", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "floor"
    t.integer  "building_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "market_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campus_id"
  end

  create_table "menus", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "poi_id"
    t.datetime "date"
    t.integer  "price"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "init_date"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
  end

  create_table "poi_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "pois", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poi_type_id"
    t.integer  "campus_id"
    t.integer  "user_id"
  end

  create_table "privileges", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "privileges_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "privilege_id"
  end

  create_table "professors", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "status",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poi_id"
    t.boolean  "approved",   :default => false
  end

  create_table "push_messages", :force => true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sent"
  end

  create_table "questions", :force => true do |t|
    t.integer  "question_type"
    t.string   "question"
    t.boolean  "mandatory"
    t.string   "help"
    t.string   "answers"
    t.integer  "question_number"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.integer  "privacy_level"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.float    "lat"
    t.float    "lng"
    t.string   "code"
    t.string   "description"
    t.integer  "university_id"
  end

  create_table "tokens", :force => true do |t|
    t.string   "phone_id"
    t.string   "platform"
    t.float    "last_lat"
    t.float    "last_lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        :default => true
    t.integer  "university_id"
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_courses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "university_id"
  end

  create_table "vertices", :force => true do |t|
    t.integer  "building_id"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
