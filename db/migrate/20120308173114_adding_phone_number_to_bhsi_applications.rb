class AddingPhoneNumberToBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.string :phone_number, :null => false
    end
  end
end
