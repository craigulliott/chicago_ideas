class CreateStaffBios < ActiveRecord::Migration
  def change
    create_table :staff_bios do |t|
      t.integer :user_id, :null => false
      t.integer :sort, :null => false
      t.string :title, :null => false
      t.text :about, :null => false
      t.timestamps
    end
    
    add_index :staff_bios, :user_id
    add_foreign_key :staff_bios, :users    
    
  end
end
