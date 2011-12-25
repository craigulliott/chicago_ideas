# days and years are such a huge part of how we organise the data, that I decided to create a day and year model
class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      # this will allow us to use relationships, and will facilitate some very DRY and sane code
      t.integer :year_id, :null => false
      # days have names (internally we call them narratives)
      t.string :name, :null => false
      # when exactly is this day
      t.date :date, :null => false

      t.timestamps
    end
    # days must be unique
    add_index :days, :date, :unique => true
    
    add_index :days, :year_id
    add_foreign_key :days, :years
    
  end
end
