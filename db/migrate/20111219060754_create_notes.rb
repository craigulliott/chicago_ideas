class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      
      # belongs_to :author, :class_name => 'User'
      # author is optional, as we may want to generate notes on something like a rake_task
      t.integer :author_id, :null => true
      
      t.text :body, :null => false

      # polymorphic - lots of other objects have notes
      t.string :asset_type, :null => false
      t.integer :asset_id, :null => false

      # allow a note to have one attachment
      t.string :attachment_file_name, :null => true
      t.string :attachment_content_type, :null => true
      t.integer :attachment_file_size, :null => true
      t.datetime :attachment_updated_at, :null => true

      t.timestamps
    end
    add_index :notes, [:asset_type, :asset_id]
    
    add_index :notes, :author_id
    add_foreign_key :notes, :users, :column => :author_id
    
  end
end
