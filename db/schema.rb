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

ActiveRecord::Schema.define(:version => 20120217214055) do

  create_table "affiliate_event_applications", :force => true do |t|
    t.string   "first_name",           :null => false
    t.string   "last_name",            :null => false
    t.string   "organization_name",    :null => false
    t.string   "website"
    t.string   "job_title"
    t.string   "email",                :null => false
    t.string   "phone_number",         :null => false
    t.string   "event_name",           :null => false
    t.string   "event_date",           :null => false
    t.string   "event_location",       :null => false
    t.string   "event_capacity",       :null => false
    t.string   "event_overview",       :null => false
    t.boolean  "recurring"
    t.boolean  "paid_event"
    t.string   "event_cost"
    t.boolean  "rsvp_required",        :null => false
    t.string   "rsvp_directions"
    t.boolean  "promote_event",        :null => false
    t.boolean  "event_info_available", :null => false
    t.boolean  "not_make_changes",     :null => false
    t.integer  "user_id",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affiliate_event_applications", ["user_id"], :name => "index_affiliate_event_applilcations_on_user_id"

  create_table "chapter_photos", :force => true do |t|
    t.string   "photo_file_name",    :null => false
    t.string   "photo_content_type", :null => false
    t.integer  "photo_file_size",    :null => false
    t.datetime "photo_updated_at",   :null => false
    t.integer  "chapter_id",         :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapter_photos", ["chapter_id"], :name => "index_chapter_photos_on_chapter_id"

  create_table "chapters", :force => true do |t|
    t.integer  "sort",                                            :null => false
    t.string   "title"
    t.text     "description"
    t.integer  "talk_id",                                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vimeo_id"
    t.boolean  "featured_on_talk",             :default => false, :null => false
    t.boolean  "featured_on_homepage",         :default => false, :null => false
    t.text     "homepage_caption"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "homepage_banner_file_name"
    t.string   "homepage_banner_content_type"
    t.integer  "homepage_banner_file_size"
    t.datetime "homepage_banner_updated_at"
  end

  add_index "chapters", ["talk_id", "sort"], :name => "index_chapters_on_talk_id_and_sort"
  add_index "chapters", ["talk_id"], :name => "index_chapters_on_talk_id"

  create_table "community_partner_applications", :force => true do |t|
    t.string   "name",                                                :null => false
    t.text     "description"
    t.string   "address1",                                            :null => false
    t.string   "address2"
    t.string   "city",                                                :null => false
    t.string   "state",                                               :null => false
    t.string   "country",                           :default => "US", :null => false
    t.boolean  "public_mailing_list"
    t.integer  "user_id",                                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_page"
    t.string   "twitter_handle"
    t.string   "contact_name",                                        :null => false
    t.string   "contact_title",                                       :null => false
    t.string   "contact_phone",                                       :null => false
    t.boolean  "previous_partner",                                    :null => false
    t.text     "why_partner",                                         :null => false
    t.boolean  "design_with_purpose_theme"
    t.boolean  "start_something_theme"
    t.boolean  "fashion_theme"
    t.boolean  "sports_theme"
    t.boolean  "cities_theme"
    t.boolean  "politics_theme"
    t.boolean  "philanthropy_theme"
    t.boolean  "tech_theme"
    t.boolean  "breathroughs_in_science_theme"
    t.boolean  "creative_process_theme"
    t.boolean  "health_wellness_theme"
    t.boolean  "future_of_news_theme"
    t.boolean  "influence_of_art_theme"
    t.boolean  "food_theme"
    t.boolean  "good_evil_theme"
    t.boolean  "social_entrepreneurship_theme"
    t.boolean  "explorers_theme"
    t.boolean  "disruptive_innovation_theme"
    t.boolean  "future_of_military_theme"
    t.boolean  "music_theme"
    t.boolean  "religion_theme"
    t.boolean  "epic_friendships_theme"
    t.boolean  "economy_theme"
    t.boolean  "future_leaders_theme"
    t.boolean  "education_theme"
    t.boolean  "meaning_of_life_theme"
    t.boolean  "environment_theme"
    t.boolean  "criminal_justice_theme"
    t.boolean  "storytellers_theme"
    t.boolean  "gender_theme"
    t.string   "most_important"
    t.boolean  "organization_has_newsletter"
    t.string   "organization_newsletter_frequency"
    t.boolean  "ciw_updates_in_newsletter"
    t.boolean  "will_promote_ciw",                                    :null => false
    t.boolean  "encourage_promote_ciw",                               :null => false
    t.boolean  "provide_insight_guidance",                            :null => false
    t.string   "contact_email",                                       :null => false
  end

  add_index "community_partner_applications", ["user_id"], :name => "index_community_partner_applications_on_user_id"

  create_table "days", :force => true do |t|
    t.integer  "year_id",    :null => false
    t.string   "name",       :null => false
    t.date     "date",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["date"], :name => "index_days_on_date"
  add_index "days", ["year_id"], :name => "index_days_on_year_id"

  create_table "event_brands", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_brands", ["name"], :name => "index_event_brands_on_name"

  create_table "event_photos", :force => true do |t|
    t.string   "photo_file_name",    :null => false
    t.string   "photo_content_type", :null => false
    t.integer  "photo_file_size",    :null => false
    t.datetime "photo_updated_at",   :null => false
    t.integer  "event_id",           :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_photos", ["event_id"], :name => "index_event_photos_on_event_id"

  create_table "events", :force => true do |t|
    t.string   "name",                :limit => 150, :null => false
    t.text     "description"
    t.integer  "partner_id"
    t.integer  "day_id",                             :null => false
    t.integer  "venue_id",                           :null => false
    t.integer  "event_brand_id",                     :null => false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.time     "start_time",                         :null => false
    t.time     "end_time",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["day_id"], :name => "index_events_on_day_id"
  add_index "events", ["event_brand_id"], :name => "index_events_on_event_brand_id"
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
    t.string   "name",              :limit => 100, :null => false
    t.text     "description"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
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

  create_table "press_clippings", :force => true do |t|
    t.string   "title",              :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.text     "body",       :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["user_id"], :name => "index_quotes_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sponsors", :force => true do |t|
    t.string   "name",                 :limit => 150, :null => false
    t.text     "description"
    t.integer  "sponsorship_level_id",                :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "sponsors", ["sponsorship_level_id"], :name => "index_sponsors_on_sponsorship_level_id"

  create_table "sponsorship_levels", :force => true do |t|
    t.string   "name",       :limit => 150, :null => false
    t.integer  "sort",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorship_levels", ["sort"], :name => "index_sponsorship_levels_on_sort"

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

  create_table "talk_brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talk_brands", ["name"], :name => "index_talk_brands_on_name"

  create_table "talk_photos", :force => true do |t|
    t.string   "photo_file_name",    :null => false
    t.string   "photo_content_type", :null => false
    t.integer  "photo_file_size",    :null => false
    t.datetime "photo_updated_at",   :null => false
    t.integer  "talk_id",            :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talk_photos", ["talk_id"], :name => "index_talk_photos_on_talk_id"

  create_table "talks", :force => true do |t|
    t.string   "name",          :limit => 150, :null => false
    t.text     "description"
    t.integer  "day_id",                       :null => false
    t.integer  "venue_id",                     :null => false
    t.integer  "track_id"
    t.integer  "talk_brand_id",                :null => false
    t.time     "start_time",                   :null => false
    t.time     "end_time",                     :null => false
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talks", ["day_id"], :name => "index_talks_on_day_id"
  add_index "talks", ["sponsor_id"], :name => "index_talks_on_sponsor_id"
  add_index "talks", ["talk_brand_id"], :name => "index_talks_on_talk_brand_id"
  add_index "talks", ["track_id"], :name => "index_talks_on_topic_id"
  add_index "talks", ["venue_id"], :name => "index_talks_on_venue_id"

  create_table "tracks", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",                                     :null => false
    t.boolean  "admin",                                 :default => false, :null => false
    t.boolean  "speaker",                               :default => false, :null => false
    t.boolean  "staff",                                 :default => false, :null => false
    t.boolean  "volunteer",                             :default => false, :null => false
    t.string   "name"
    t.string   "phone"
    t.integer  "fb_uid"
    t.string   "fb_access_token"
    t.string   "twitter_token"
    t.string   "twitter_secret"
    t.string   "title"
    t.text     "bio"
    t.string   "twitter_screen_name"
    t.string   "permalink",              :limit => 150
    t.string   "portrait_file_name"
    t.string   "portrait_content_type"
    t.integer  "portrait_file_size"
    t.datetime "portrait_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "portrait2_file_name"
    t.string   "portrait2_content_type"
    t.integer  "portrait2_file_size"
    t.datetime "portrait2_updated_at"
    t.boolean  "newsletter",                            :default => true,  :null => false
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token"
  add_index "users", ["deleted_at"], :name => "index_users_on_deleted_at"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["fb_access_token"], :name => "index_users_on_fb_access_token"
  add_index "users", ["fb_uid"], :name => "index_users_on_fb_uid"
  add_index "users", ["permalink"], :name => "index_users_on_permalink"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["speaker"], :name => "index_users_on_speaker"
  add_index "users", ["staff"], :name => "index_users_on_staff"
  add_index "users", ["volunteer"], :name => "index_users_on_volunteer"

  create_table "venues", :force => true do |t|
    t.string   "name",                :limit => 100,                   :null => false
    t.string   "address1",            :limit => 100,                   :null => false
    t.string   "address2",            :limit => 100
    t.string   "city",                :limit => 100,                   :null => false
    t.string   "state",               :limit => 100,                   :null => false
    t.string   "zipcode",             :limit => 100,                   :null => false
    t.string   "country",             :limit => 2,   :default => "US", :null => false
    t.point    "lonlat",              :limit => nil,                   :null => false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["name"], :name => "index_venues_on_name"

  create_table "volunteers", :force => true do |t|
    t.integer  "user_id"
    t.string   "postcode"
    t.boolean  "employed"
    t.text     "why"
    t.text     "what"
    t.text     "availability"
    t.boolean  "street_team"
    t.boolean  "avail_mon"
    t.boolean  "avail_tue"
    t.boolean  "avail_wed"
    t.boolean  "avail_thu"
    t.boolean  "avail_fri"
    t.boolean  "avail_sat"
    t.boolean  "avail_sun"
    t.boolean  "avail_time_1"
    t.boolean  "avail_time_2"
    t.boolean  "avail_time_3"
    t.boolean  "avail_time_4"
    t.boolean  "avail_time_5"
    t.boolean  "avail_time_6"
    t.string   "hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "volunteers", ["user_id"], :name => "index_volunteers_on_user_id"

  create_table "years", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "affiliate_event_applications", "users", :name => "affiliate_event_applilcations_user_id_fk"

  add_foreign_key "community_partner_applications", "users", :name => "community_partner_applications_user_id_fk"

  add_foreign_key "volunteers", "users", :name => "volunteers_user_id_fk"

end
