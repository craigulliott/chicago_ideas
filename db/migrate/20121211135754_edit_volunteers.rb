class EditVolunteers < ActiveRecord::Migration
  
  def up
    change_column :volunteers, :type_of_position, :string, :null => true
    add_column :volunteers, :organization_name_1, :string, :null => true
    add_column :volunteers, :organization_department_1, :string, :null => true
    add_column :volunteers, :organization_title_1, :string, :null => true
    add_column :volunteers, :organization_name_2, :string, :null => true
    add_column :volunteers, :organization_department_2, :string, :null => true
    add_column :volunteers, :organization_title_2, :string, :null => true
    add_column :volunteers, :organization_name_3, :string, :null => true
    add_column :volunteers, :organization_department_3, :string, :null => true
    add_column :volunteers, :organization_title_3, :string, :null => true
    add_column :volunteers, :interests_volunteering, :text, :null => true
    add_column :volunteers, :skills, :text, :null => true
    
  end

  def down
    change_column :volunteers, :type_of_position, :string, :null => false
    remove_column :volunteers, :organization_name_1
    remove_column :volunteers, :organization_department_1
    remove_column :volunteers, :organization_title_1
    remove_column :volunteers, :organization_name_2
    remove_column :volunteers, :organization_department_2
    remove_column :volunteers, :organization_title_2
    remove_column :volunteers, :organization_name_3
    remove_column :volunteers, :organization_department_3
    remove_column :volunteers, :organization_title_3
    remove_column :volunteers, :interests_volunteering, :text
    remove_column :volunteers, :skills, :text
  end
end
