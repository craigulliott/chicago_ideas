class EvenMoreUpdatesToCommunityPartnersApplication < ActiveRecord::Migration
  def up
    add_column :community_partner_applications, :other_newsletter_frequency, :string
  end

  def down
    remove_column :community_partner_applications, :other_newsletter_frequency, :string
  end
end
