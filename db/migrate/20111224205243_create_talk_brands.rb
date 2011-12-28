class CreateTalkBrands < ActiveRecord::Migration
  def change
    create_table :talk_brands do |t|
      t.string :name, :null => true

      t.timestamps
    end
    add_index :talk_brands, :name, :unique => true

  end
end
