class AddingUserColumnToBhsiApplicaion < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.integer :user_id, :null => false
    end
  end
end
