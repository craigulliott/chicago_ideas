class UpdatesToCommunityPartnerApplication < ActiveRecord::Migration
  def up
    add_column :community_partner_applications, :most_important_other, :text
  end

  def down
    remove_column :community_partner_applications, :most_important_other, :text
  end
end
