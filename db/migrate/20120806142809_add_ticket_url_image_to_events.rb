class AddTicketUrlImageToEvents < ActiveRecord::Migration

  def up
    add_column :events, :ticket_url, :string, :null => true
    add_column :events, :lab_host_file_name, :string, :null => true
    add_column :events, :lab_host_content_type, :string, :null => true
    add_column :events, :lab_host_file_size, :integer, :null => true
    add_column :events, :lab_host_updated_at, :datetime, :null => true
  end

  def down
    remove_column :events, :ticket_url
    remove_column :events, :lab_host_file_name
    remove_column :events, :lab_host_content_type
    remove_column :events, :lab_host_file_size
    remove_column :events, :lab_host_updated_at
  end

end
