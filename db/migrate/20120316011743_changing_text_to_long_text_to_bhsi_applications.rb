class ChangingTextToLongTextToBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      
      t.change :first_name, :text, :limit => 655365
      t.change :last_name, :text, :limit => 655365
      t.change :address1, :text, :limit => 655365
      t.change :address2, :text, :limit => 655365
      t.change :city, :text, :limit => 655365
      t.change :state, :text, :limit => 655365
      t.change :email, :text, :limit => 655365
      t.change :gender, :text, :limit => 655365
      t.change :birthdate, :text, :limit => 655365
      
      t.change :title, :text, :limit => 655365
      t.change :social_venture_name, :text, :limit => 655365
      t.change :legal_structure, :text, :limit => 655365
      t.change :url, :text, :limit => 655365
      t.change :twitter_handle, :text, :limit => 655365
      t.change :video_url, :text, :limit => 655365
      t.change :applied_before, :text, :limit => 655365
      t.change :venture_launched, :text, :limit => 655365
      t.change :number_people_affected, :text, :limit => 655365
      t.change :zipcode, :text, :limit => 655365
      t.change :reference_1_name, :text, :limit => 655365
      t.change :reference_1_phone, :text, :limit => 655365
      t.change :reference_1_email, :text, :limit => 655365
      t.change :reference_1_relationship, :text, :limit => 655365
      t.change :reference_2_name, :text, :limit => 655365
      t.change :reference_2_phone, :text, :limit => 655365
      t.change :reference_2_email, :text, :limit => 655365
      t.change :reference_2_relationship, :text, :limit => 655365
      t.change :phone_number, :text, :limit => 655365


    end
  end
end
