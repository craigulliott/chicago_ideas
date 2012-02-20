class CreateAffiliateEventApplilcations < ActiveRecord::Migration
  def change
    create_table :affiliate_event_applilcations do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :organization_name, :null => false
      t.string :website, :null => true
      t.string :job_title, :null => true
      t.string :email, :null => false
      t.string :phone_number, :null => false
      t.string :first_name, :null => false
      t.string :event_name, :null => false
      t.datetime :event_date, :null => false
      t.string :event_location, :null => false
      t.string :event_capacity, :null => false
      t.string :event_overview, :null => false
      t.boolean :recurring
      t.boolean :paid_event
      t.string :event_cost
      t.boolean :rsvp_required, :null => false
      t.string :rsvp_directions
      t.boolean :promote_event, :null => false
      t.boolean :event_info_available, :null => false
      t.boolean :not_make_changes, :null => false
      t.integer :user_id, :null => false
      t.timestamps      
    end

    add_index :affiliate_event_applilcations, :user_id
    add_foreign_key :affiliate_event_applilcations, :users

  end
end
