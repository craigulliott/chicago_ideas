class CreateMemberTypes < ActiveRecord::Migration
  def change
    create_table :member_types do |t|
      t.string :name, :null => true

      t.timestamps
    end
    add_index :member_types, :name, :unique => true

  end
end
