class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.integer :user_id, :null => true
      t.string :postcode, :null => true
      t.boolean :employed, :null => true
      t.text :why, :null => true
      t.text :what, :null => true
      t.text :availability, :null => true
      t.boolean :street_team, :null => true
      t.boolean :avail_mon, :null => true
      t.boolean :avail_tue, :null => true
      t.boolean :avail_wed, :null => true
      t.boolean :avail_thu, :null => true
      t.boolean :avail_fri, :null => true
      t.boolean :avail_sat, :null => true
      t.boolean :avail_sun, :null => true
      t.boolean :avail_time_1, :null => true
      t.boolean :avail_time_2, :null => true
      t.boolean :avail_time_3, :null => true
      t.boolean :avail_time_4, :null => true
      t.boolean :avail_time_5, :null => true
      t.boolean :avail_time_6, :null => true
      t.string :hours, :null => true

      t.timestamps
    end

    add_index :volunteers, :user_id
    add_foreign_key :volunteers, :users

  end
end
