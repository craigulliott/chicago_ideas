class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :sort, :null => false
      t.string :title, :null => true
      t.text :description, :null => true
      t.integer :talk_id, :null => false

      t.timestamps
    end

    add_index :chapters, [:talk_id, :sort], :unique => true

    add_index :chapters, :talk_id
    add_foreign_key :chapters, :talks
  end
end
