class UpdatingPreviousPartnerBooleanToCommunityPartnerApplication < ActiveRecord::Migration
  def up
    change_column :community_partner_applications, :previous_partner, :boolean, :default => false
  end

  def down
    change_column :community_partner_applications, :previous_partner, :boolean, :default => true
  end
end
