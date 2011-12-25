class CreateChapters < ActiveRecord::Migration
  def change
    # CIW talks are made up of several chapters
    create_table :chapters do |t|
      t.integer :order, :null => false
      t.integer :talk_id, :null => false

      t.timestamps
    end
    add_index :chapters, [:talk_id, :order], :unique => true

    add_index :chapters, :talk_id
    add_foreign_key :chapters, :talks
  end
end
