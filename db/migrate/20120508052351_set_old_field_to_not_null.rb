class SetOldFieldToNotNull < ActiveRecord::Migration
  def change
    change_table "bhsi_applications", :force => true do |t|    
      t.change     "about_yourself",                       :text, :limit => 16777215,                    :null => true
      t.change     "social_venture_description",           :text, :limit => 16777215,                    :null => true
      t.change     "venture_launched",                     :text, :limit => 16777215,                    :null => true
      t.change     "number_people_affected",               :text, :limit => 16777215,                    :null => true
      t.change     "explain_number",                       :text, :limit => 16777215,                    :null => true
      t.change     "organizational_development",           :text, :limit => 16777215,                    :null => true
      t.change     "makes_social_innovation",              :text, :limit => 16777215,                    :null => true
      t.change     "inspiration",                          :text, :limit => 16777215,                    :null => true
      t.change     "sustainability_model",                 :text, :limit => 16777215,                    :null => true
      t.change     "improvements",                         :text, :limit => 16777215,                    :null => true
      t.change     "distinguish_yourself",                 :text, :limit => 16777215,                    :null => true
      t.change     "strong_midwest_connections_explained", :text, :limit => 16777215
      t.change     "additional_comments",                  :text, :limit => 16777215
      t.change     "three_standout_statistics",            :text, :limit => 16777215,                    :null => true
    end
  end
end
