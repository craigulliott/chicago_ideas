class RenameAffiliateEventApplilcationsToAffiliateEventsApplication < ActiveRecord::Migration
  def change
    rename_table :affiliate_event_applilcations, :affiliate_event_applications
  end
end
