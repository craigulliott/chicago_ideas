class UpdateFieldsToAffiliateEventApplication < ActiveRecord::Migration
  def up
    change_column :affiliate_event_applications, :recurring, :string
    change_column :affiliate_event_applications, :paid_event, :string
    change_column :affiliate_event_applications, :rsvp_required, :string
    add_column :affiliate_event_applications, :description_25words, :text, :null => false
    add_column :affiliate_event_applications, :description_10words, :text, :null => false
  end

  def down
    change_column :affiliate_event_applications, :recurring, :boolean
    change_column :affiliate_event_applications, :paid_event, :boolean
    change_column :affiliate_event_applications, :rsvp_required, :boolean
    remove_column :affiliate_event_applications, :description_25words, :text, :null => false
    remove_column :affiliate_event_applications, :description_10words, :text, :null => false
  end
end
