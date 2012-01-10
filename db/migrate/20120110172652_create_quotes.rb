class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :body, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :quotes, :user_id
    add_foreign_key :quotes, :users

  end
end
