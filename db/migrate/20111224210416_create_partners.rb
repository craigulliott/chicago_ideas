class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name, :null => false, :limit => 100

      t.timestamps
    end
  end
end
