class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|

      t.string :caption, :null => false

      # polymorphic - lots of other objects have photos
      t.string :asset_type, :null => false
      t.integer :asset_id, :null => false

      # allow a photo to have one image
      t.string :image_file_name, :null => true
      t.string :image_content_type, :null => true
      t.integer :image_file_size, :null => true
      t.datetime :image_updated_at, :null => true

      t.timestamps
    end
    add_index :photos, [:asset_type, :asset_id]

  end
end
