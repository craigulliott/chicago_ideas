class UpdatesToCommunityPartnersForm < ActiveRecord::Migration
  def up
    change_column :community_partner_applications, :previous_partner, :string
  end

  def down
    change_column :community_partner_applications, :previous_partner, :boolean
  end
end
