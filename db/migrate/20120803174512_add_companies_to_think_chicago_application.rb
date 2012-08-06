class AddCompaniesToThinkChicagoApplication < ActiveRecord::Migration
  
  def up
    add_column :think_chicago_applications, :companies, :longtext, :null => false, :default => ""
  end

  def down
    remove_column :think_chicago_applications, :companies
  end
  
end
