class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, :null => false
      t.text :description, :null => false

      t.timestamps
    end
  end
end
