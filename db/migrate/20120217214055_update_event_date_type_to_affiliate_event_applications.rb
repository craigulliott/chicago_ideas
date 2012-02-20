class UpdateEventDateTypeToAffiliateEventApplications < ActiveRecord::Migration
  def up
    change_column :affiliate_event_applications, :event_date, :string
  end

  def down
    change_column :affiliate_event_applications, :event_date, :datetime
  end
end
