class AddingInstigatorsToCommunityPartnersApplications < ActiveRecord::Migration
  def change
    change_table :community_partner_applications do |t|
      t.remove :good_evil_theme
      t.remove :start_something_theme
      t.rename :environment_theme, :earth_theme
      t.rename :gender_theme, :identity_theme
      t.boolean :instigators_theme
    end
  end
end
