class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id, :null => true
      t.string :first_name, :null => true
      t.string :last_name, :null => true
      
      t.integer :member_type_id, :null => false
      t.integer :year_id, :null => false

      t.timestamps
    end
    
    add_index :members, :user_id
    add_foreign_key :members, :users
    
    add_index :members, :member_type_id
    add_foreign_key :members, :member_types
    
    add_index :members, :year_id
    add_foreign_key :members, :years

  end
end
