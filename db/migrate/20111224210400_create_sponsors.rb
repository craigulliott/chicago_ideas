class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name, :null => false, :limit => 150
      t.text :description, :null => true

      # allow a sponsor to have a logo
      t.string :logo_file_name, :null => true
      t.string :logo_content_type, :null => true
      t.integer :logo_file_size, :null => true
      t.datetime :logo_updated_at, :null => true

      t.timestamps
    end
  end
end
