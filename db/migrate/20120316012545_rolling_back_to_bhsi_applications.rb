class RollingBackToBhsiApplications < ActiveRecord::Migration
  def up
    change_table :bhsi_applications do |t|
      
      # Changing teh varchars back to varchars
      t.change :zipcode, :string, :length => 11
      t.change :phone_number, :string, :length => 11
      t.change :first_name, :string, :length => 25
      t.change :last_name, :string, :length => 25
      t.change :address1, :string, :length => 100
      t.change :address2, :string, :length => 55
      t.change :city, :string, :length => 55
      t.change :state, :string, :length => 15
      t.change :url, :string, :length => 100
      t.change :zipcode, :string, :length => 11
      t.change :email, :string, :length => 50
      t.change :title, :string, :length => 50
      t.change :twitter_handle, :string, :length => 20
      t.change :legal_structure, :string, :length => 100
      t.change :applied_before, :string, :length => 3
      t.change :venture_launched, :string, :length => 50
      t.change :number_people_affected, :string, :length => 20
      t.change :reference_1_name, :string, :length => 50
      t.change :reference_1_phone, :string, :length => 15
      t.change :reference_1_email, :string, :length => 50
      t.change :reference_1_relationship, :string, :length => 100
      t.change :reference_2_name, :string, :length => 50
      t.change :reference_2_phone, :string, :length => 15
      t.change :reference_2_email, :string, :length => 50
      t.change :reference_2_relationship, :string, :length => 100
      
      # Changing Text to long text
      t.change :about_yourself, :text, :limit => 655365
      t.change :social_venture_description, :text, :limit => 655365
      t.change :explain_number, :text, :limit => 655365      
      t.change :organizational_development, :text, :limit => 655365
      t.change :makes_social_innovation, :text, :limit => 655365      
      t.change :inspiration, :text, :limit => 655365
      t.change :sustainability_model, :text, :limit => 655365
      t.change :improvements, :text, :limit => 655365
      t.change :distinguish_yourself, :text, :limit => 655365
      t.change :strong_midwest_connections_explained, :text, :limit => 655365
      t.change :additional_comments, :text, :limit => 655365
      t.change :three_standout_statistics, :text, :limit => 655365
    end
  end
end
