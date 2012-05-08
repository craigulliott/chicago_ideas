class MoveSomeBack < ActiveRecord::Migration
  def change
    change_table "bhsi_applications", :force => true do |t|    
      t.change     "makes_social_innovation",              :text, :limit => 16777215,                    :null => true
      t.change     "inspiration",                          :text, :limit => 16777215,                    :null => true
      t.change     "sustainability_model",                 :text, :limit => 16777215,                    :null => true
      t.change     "improvements",                         :text, :limit => 16777215,                    :null => true
      t.change     "distinguish_yourself",                 :text, :limit => 16777215,                    :null => true
    end
  end
end
