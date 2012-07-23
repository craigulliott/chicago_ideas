class CreateEdisonTalksTable < ActiveRecord::Migration
  def self.up
    create_table :edison_talks_applications do |t|
      t.string :name, :null => false
      t.string :organization, :null => true
      t.string :title, :null => true
      t.string :email, :null => false
      t.string :phone, :null => false
      
      t.text :passions, :limit => 16777215, :null => false
      t.text :why_come, :limit => 16777215, :null => false
      t.text :recommendation, :limit => 16777215, :null => false
      t.text :invention, :limit => 16777215, :null => false
      
      t.string :inspiration_1, :null => false
      t.string :inspiration_2, :null => false
      t.string :inspiration_3, :null => false
      
      t.text :comments, :limit => 16777215, :null => true
      
      t.has_attached_file :pdf

      t.timestamps

    end
  end
  
  def self.down
    drop_table :edison_talks_applications
  end

end
