class MoreUpdatesToCommunityPartnerApplication < ActiveRecord::Migration
  def up
    change_column :community_partner_applications, :organization_has_newsletter, :string
  end

  def down
    change_column :community_partner_applications, :organization_has_newsletter, :boolean
  end
end
