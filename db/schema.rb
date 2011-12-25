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

ActiveRecord::Schema.define(:version => 20111224210601) do

  create_table "chapters", :force => true do |t|
    t.integer  "order",      :null => false
    t.integer  "talk_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapters", ["talk_id", "order"], :name => "index_chapters_on_talk_id_and_order"
  add_index "chapters", ["talk_id"], :name => "index_chapters_on_talk_id"

  create_table "days", :force => true do |t|
    t.integer  "year_id",    :null => false
    t.string   "name",       :null => false
    t.date     "date",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["date"], :name => "index_days_on_date"
  add_index "days", ["year_id"], :name => "index_days_on_year_id"

  create_table "events", :force => true do |t|
    t.string   "name",        :limit => 150, :null => false
    t.text     "description"
    t.integer  "partner_id"
    t.integer  "day_id",                     :null => false
    t.integer  "venue_id",                   :null => false
    t.time     "start_time",                 :null => false
    t.time     "end_time",                   :null => false
    t.string   "type",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["day_id"], :name => "index_events_on_day_id"
  add_index "events", ["partner_id"], :name => "index_events_on_partner_id"
  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "notes", :force => true do |t|
    t.integer  "author_id"
    t.text     "body",                    :null => false
    t.string   "asset_type",              :null => false
    t.integer  "asset_id",                :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["asset_type", "asset_id"], :name => "index_notes_on_asset_type_and_asset_id"
  add_index "notes", ["author_id"], :name => "index_notes_on_author_id"

  create_table "partners", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", :force => true do |t|
    t.integer  "speaker_id", :null => false
    t.integer  "chapter_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "performances", ["chapter_id"], :name => "index_performances_on_chapter_id"
  add_index "performances", ["speaker_id", "chapter_id"], :name => "index_performances_on_speaker_id_and_chapter_id"

  create_table "photos", :force => true do |t|
    t.string   "caption",            :null => false
    t.string   "asset_type",         :null => false
    t.integer  "asset_id",           :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["asset_type", "asset_id"], :name => "index_photos_on_asset_type_and_asset_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "speakers", :force => true do |t|
    t.string   "name",                  :limit => 150, :null => false
    t.string   "title"
    t.text     "bio"
    t.string   "twitter_screen_name"
    t.string   "facebook_page_id"
    t.string   "portrait_file_name"
    t.string   "portrait_content_type"
    t.integer  "portrait_file_size"
    t.datetime "portrait_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name",              :limit => 150, :null => false
    t.text     "description"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorship_levels", :force => true do |t|
    t.string   "name",       :limit => 150, :null => false
    t.integer  "sort",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorships", :force => true do |t|
    t.integer  "sponsor_id",           :null => false
    t.integer  "year_id",              :null => false
    t.integer  "sponsorship_level_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["sponsor_id"], :name => "index_sponsorships_on_sponsor_id"
  add_index "sponsorships", ["sponsorship_level_id"], :name => "index_sponsorships_on_sponsorship_level_id"
  add_index "sponsorships", ["year_id", "sponsor_id"], :name => "index_sponsorships_on_year_id_and_sponsor_id"

  create_table "staff_bios", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "sort",       :null => false
    t.string   "title",      :null => false
    t.text     "about",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staff_bios", ["user_id"], :name => "index_staff_bios_on_user_id"

  create_table "talks", :force => true do |t|
    t.string   "name",        :limit => 150, :null => false
    t.text     "description"
    t.integer  "day_id",                     :null => false
    t.integer  "venue_id",                   :null => false
    t.integer  "topic_id",                   :null => false
    t.time     "start_time",                 :null => false
    t.time     "end_time",                   :null => false
    t.string   "type",                       :null => false
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talks", ["day_id"], :name => "index_talks_on_day_id"
  add_index "talks", ["sponsor_id"], :name => "index_talks_on_sponsor_id"
  add_index "talks", ["topic_id"], :name => "index_talks_on_topic_id"
  add_index "talks", ["venue_id"], :name => "index_talks_on_venue_id"

  create_table "topics", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",                                   :null => false
    t.boolean  "admin",                               :default => false, :null => false
    t.string   "name"
    t.integer  "fb_uid"
    t.string   "fb_access_token"
    t.string   "twitter_token"
    t.string   "twitter_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token"
  add_index "users", ["deleted_at"], :name => "index_users_on_deleted_at"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["fb_access_token"], :name => "index_users_on_fb_access_token"
  add_index "users", ["fb_uid"], :name => "index_users_on_fb_uid"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

  create_table "venues", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.string   "address1",   :limit => 100, :null => false
    t.string   "address2",   :limit => 100
    t.string   "city",       :limit => 100, :null => false
    t.string   "state",      :limit => 100, :null => false
    t.string   "zipcode",    :limit => 100, :null => false
    t.string   "country",    :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["name"], :name => "index_venues_on_name"

  create_table "videos", :force => true do |t|
    t.string   "caption",    :null => false
    t.string   "asset_type", :null => false
    t.integer  "asset_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["asset_type", "asset_id"], :name => "index_videos_on_asset_type_and_asset_id"

  create_table "years", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "chapters", "talks", :name => "chapters_talk_id_fk"

  add_foreign_key "days", "years", :name => "days_year_id_fk"

  add_foreign_key "events", "days", :name => "events_day_id_fk"
  add_foreign_key "events", "partners", :name => "events_partner_id_fk"
  add_foreign_key "events", "venues", :name => "events_venue_id_fk"

  add_foreign_key "notes", "users", :name => "notes_author_id_fk", :column => "author_id"

  add_foreign_key "performances", "chapters", :name => "performances_chapter_id_fk"
  add_foreign_key "performances", "speakers", :name => "performances_speaker_id_fk"

  add_foreign_key "sponsorships", "sponsors", :name => "sponsorships_sponsor_id_fk"
  add_foreign_key "sponsorships", "sponsorship_levels", :name => "sponsorships_sponsorship_level_id_fk"
  add_foreign_key "sponsorships", "years", :name => "sponsorships_year_id_fk"

  add_foreign_key "staff_bios", "users", :name => "staff_bios_user_id_fk"

  add_foreign_key "talks", "days", :name => "talks_day_id_fk"
  add_foreign_key "talks", "sponsors", :name => "talks_sponsor_id_fk"
  add_foreign_key "talks", "topics", :name => "talks_topic_id_fk"
  add_foreign_key "talks", "venues", :name => "talks_venue_id_fk"

end
