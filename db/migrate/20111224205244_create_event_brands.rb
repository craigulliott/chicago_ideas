class CreateEventBrands < ActiveRecord::Migration
  def change
    create_table :event_brands do |t|
      t.string :name, :null => false

      t.timestamps
    end
    add_index :event_brands, :name, :unique => true
  end
end
