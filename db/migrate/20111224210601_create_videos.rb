class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|

      t.string :caption, :null => false

      # polymorphic - lots of other objects have videos
      t.string :asset_type, :null => false
      t.integer :asset_id, :null => false

      t.timestamps
    end
    add_index :videos, [:asset_type, :asset_id]

  end
end
