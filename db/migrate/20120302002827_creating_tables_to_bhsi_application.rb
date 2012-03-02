class CreatingTablesToBhsiApplication < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :address1, :null => false
      t.string :address2, :null => true
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :country, :null => false, :default => 'US'
      t.string :email, :null => false
      t.string :gender, :null => false
      t.string :birthdate, :null => false
      t.string :title, :null => false
      t.string :social_venture_name, :null => false
      t.string :legal_structure, :null => false
      t.string :url, :null => false
      t.string :twitter_handle, :null => false
      t.string :video_url, :null => false
      t.string :applied_before, :null => false
      t.string :about_yourself, :null => false
      t.string :social_venture_description, :null => false
      t.string :venture_launched, :null => false
      t.string :number_people_affected, :null => false
      t.string :explain_number, :null => false
      t.string :standout_statistics, :null => false
      t.string :organizational_development, :null => false
      t.string :makes_social_innovation, :null => false
      t.string :inspiration, :null => false
      t.string :sustainability_model, :null => false
      t.string :improvements, :null => false
      t.string :distinguish_yourself
      t.string :strong_midwest_connections, :null => false
      t.string :strong_midwest_connections_explained
      t.string :additional_comments
      
      t.string :previous_budget, :null => false
      
      t.string :reference_1_name, :null => false
      t.string :reference_1_relationship, :null => false
      t.string :reference_1_phone, :null => false
      t.string :reference_1_email, :null => false
      t.string :reference_2_name, :null => false
      t.string :reference_2_relationship, :null => false
      t.string :reference_2_phone, :null => false
      t.string :reference_2_email, :null => false
      
      t.string :press_clipping_1, :null => false
      t.string :press_clipping_2, :null => false
      t.string :press_clipping_3, :null => false

    end
  end

end
