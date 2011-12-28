class CreateSponsorshipLevels < ActiveRecord::Migration
  def change
    create_table :sponsorship_levels do |t|
      t.string :name, :null => false, :limit => 150
      t.integer :sort, :null => false

      t.timestamps
    end
    add_index :sponsorship_levels, :sort, :unique => true
  end
end
