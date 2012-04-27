class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title, :null => false
      t.text :body, :null => false
      t.string :url, :null => true
      t.boolean :published, :null => true, :default => '1'
      t.timestamps
    end

  end
end
