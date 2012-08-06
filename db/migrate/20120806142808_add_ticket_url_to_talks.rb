class AddTicketUrlToTalks < ActiveRecord::Migration
  
  def up
    add_column :talks, :ticket_url, :string, :null => true
  end

  def down
    remove_column :talks, :ticket_url
  end
end
