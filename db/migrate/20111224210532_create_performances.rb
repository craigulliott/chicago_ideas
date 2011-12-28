class CreatePerformances < ActiveRecord::Migration
  def change
    # many speakers can be present in a specific chapter
    # talks are made up of multiple chapters
    create_table :performances do |t|
      t.integer :speaker_id, :null => false
      t.integer :chapter_id, :null => false

      t.timestamps
    end

    add_index :performances, [:speaker_id, :chapter_id], :unique => true
    add_foreign_key :performances, :users, :column => :speaker_id

    add_index :performances, :chapter_id
    add_foreign_key :performances, :chapters

  end
end
