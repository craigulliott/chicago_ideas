# days and years are such a huge part of how we organise the data, that I decided to create a day and year model
class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      # this model will have an id field only, and this id will be the actual year  (2011, 2012 etc.)
      t.timestamps
    end
  end
end
