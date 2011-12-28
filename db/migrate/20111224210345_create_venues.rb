class CreateVenues < ActiveRecord::Migration
  def change

    create_table :venues do |t|
      t.string :name, :null => false, :limit => 100
      t.string :address1, :null => false, :limit => 100
      t.string :address2, :limit => 100
      t.string :city, :null => false, :limit => 100
      t.string :state, :null => false, :limit => 100
      t.string :zipcode, :null => false, :limit => 100
      t.string :country, :null => false, :limit => 2, :default => 'US'
      t.point :lonlat, :null => false

      t.timestamps
    end
    # for when we serach by name
    add_index :venues, :name

  end
end

