class RemoveFieldsFromBhsilong < ActiveRecord::Migration
  def change
    change_table "bhsi_longtexts", :force => true do |t|    
      t.remove     "makes_social_innovation"
      t.remove     "inspiration"
      t.remove     "sustainability_model"
      t.remove     "improvements"
      t.remove     "distinguish_yourself"
    end
  end
end

