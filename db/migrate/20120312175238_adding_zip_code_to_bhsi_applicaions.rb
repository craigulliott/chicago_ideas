class AddingZipCodeToBhsiApplicaions < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.string :zipcode, :null => false
    end
  end
end
