class AddingFieldsToVolunteersForm < ActiveRecord::Migration
  def up
    add_column :volunteers, :first_name, :string, :null => false
    add_column :volunteers, :last_name, :string, :null => false
    add_column :volunteers, :phone, :string, :null => false
    add_column :volunteers, :email, :string, :null => false
    add_column :volunteers, :zip_code, :string
    add_column :volunteers, :interested_in_promoting, :boolean
    add_column :volunteers, :type_of_position, :string, :null => false
    add_column :volunteers, :specific_event_interest, :string
    add_column :volunteers, :interested_in_youth_program, :boolean
    add_column :volunteers, :anything_else, :text
  end

  def down
    remove_column :volunteers, :first_name, :string, :null => false
    remove_column :volunteers, :last_name, :string, :null => false
    remove_column :volunteers, :phone, :string, :null => false
    remove_column :volunteers, :email, :string, :null => false
    remove_column :volunteers, :zip_code, :string
    remove_column :volunteers, :interested_in_promoting, :boolean
    remove_column :volunteers, :type_of_position, :string, :null => false
    remove_column :volunteers, :specific_event_interest, :string
    remove_column :volunteers, :interested_in_youth_program, :boolean
    remove_column :volunteers, :anything_else, :text
  end
end
