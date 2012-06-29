class CreateThinkChicagoTable < ActiveRecord::Migration
  def self.up
    create_table :think_chicago_applications do |t|
      t.string :first_name, :null => false
      t.string :middle_name, :null => true
      t.string :last_name, :null => false
      t.string :address1, :null => false
      t.string :address2, :null => true
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :zip, :null => false
      t.string :phone, :null => false
      t.string :email, :null => false
      t.string :how_learn, :null => false
      t.string :how_learn_extra, :null => true
      t.string :undergraduate_institutions, :null => false
      t.string :field_major, :null => false
      t.string :minor, :null => true
      t.string :dates_attended, :null => false
      t.string :gpa, :null => false
      t.string :degree_type, :null => false
      t.string :expected_graduation_date, :null => false
      t.string :employment_interests, :null => false
      t.string :employment_interests_extra, :null => true
      
      t.text :honors_experience_activities, :limit => 16777215, :null => false
      t.text :qualities_attributes, :limit => 16777215, :null => false
      t.text :hope_to_gain,:limit => 16777215, :null => false
      
      t.has_attached_file :current_resume
      t.has_attached_file :unofficial_transcript
      t.has_attached_file :faculty_endorsement

      t.timestamps

    end
  end
  
  def self.down
    drop_table :think_chicago_applications
  end

end
