class UpdatesToAffilateEventForm < ActiveRecord::Migration
  def up
    change_column :affiliate_event_applications, :rsvp_required, :string, :null => true
    change_column :affiliate_event_applications, :event_overview, :text
  end

  def down
    change_column :affiliate_event_applications, :rsvp_required, :string, :null => false
    change_column :affiliate_event_applications, :event_overview, :string
  end
end
