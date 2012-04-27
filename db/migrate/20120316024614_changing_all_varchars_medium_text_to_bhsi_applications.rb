class ChangingAllVarcharsMediumTextToBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :zipcode, :text
      t.change :phone_number, :text
      t.change :first_name, :text
      t.change :last_name, :text
      t.change :address1, :text
      t.change :address2, :text
      t.change :city, :text
      t.change :state, :text
      t.change :url, :text
      t.change :zipcode, :text
      t.change :email, :text
      t.change :title, :text
      t.change :twitter_handle, :text
      t.change :legal_structure, :text
      t.change :applied_before, :text
      t.change :venture_launched, :text
      t.change :number_people_affected, :text
      t.change :reference_1_name, :text
      t.change :reference_1_phone, :text
      t.change :reference_1_email, :text
      t.change :reference_1_relationship, :text
      t.change :reference_2_name, :text
      t.change :reference_2_phone, :text
      t.change :reference_2_email, :text
      t.change :reference_2_relationship, :text
    end
  end
end
