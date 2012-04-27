class LimitLengthWhatsTheDifferenceToBhsiApplicaions < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :zipcode, :string, :limit => 11
      t.change :phone_number, :string, :limit => 11
      t.change :first_name, :string, :limit => 25
      t.change :last_name, :string, :limit => 25
      t.change :address1, :string, :limit => 100
      t.change :address2, :string, :limit => 55
      t.change :city, :string, :limit => 55
      t.change :state, :string, :limit => 15
      t.change :url, :string, :limit => 100
      t.change :zipcode, :string, :limit => 11
      t.change :email, :string, :limit => 50
      t.change :title, :string, :limit => 50
      t.change :twitter_handle, :string, :limit => 20
      t.change :legal_structure, :string, :limit => 100
      t.change :applied_before, :string, :limit => 3
      t.change :venture_launched, :string, :limit => 50
      t.change :number_people_affected, :string, :limit => 20
      t.change :reference_1_name, :string, :limit => 50
      t.change :reference_1_phone, :string, :limit => 15
      t.change :reference_1_email, :string, :limit => 50
      t.change :reference_1_relationship, :string, :limit => 100
      t.change :reference_2_name, :string, :limit => 50
      t.change :reference_2_phone, :string, :limit => 15
      t.change :reference_2_email, :string, :limit => 50
      t.change :reference_2_relationship, :string, :limit => 100
    end
  end
end
