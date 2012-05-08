class CreatBhsiLong < ActiveRecord::Migration
  def change
    create_table "bhsi_longtexts", :force => true do |t|    
      t.text     "about_yourself",                       :limit => 16777215,                    :null => false
      t.text     "social_venture_description",           :limit => 16777215,                    :null => false
      t.text     "venture_launched",                     :limit => 16777215,                    :null => false
      t.text     "number_people_affected",               :limit => 16777215,                    :null => false
      t.text     "explain_number",                       :limit => 16777215,                    :null => false
      t.text     "organizational_development",           :limit => 16777215,                    :null => false
      t.text     "makes_social_innovation",              :limit => 16777215,                    :null => false
      t.text     "inspiration",                          :limit => 16777215,                    :null => false
      t.text     "sustainability_model",                 :limit => 16777215,                    :null => false
      t.text     "improvements",                         :limit => 16777215,                    :null => false
      t.text     "distinguish_yourself",                 :limit => 16777215,                    :null => false
      t.text     "strong_midwest_connections_explained", :limit => 16777215
      t.text     "additional_comments",                  :limit => 16777215
      t.text     "three_standout_statistics",            :limit => 16777215,                    :null => false
      t.integer  "bhsi_application_id"
    end
    
  end
end
