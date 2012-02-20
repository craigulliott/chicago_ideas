class AddFieldsToCommunityPartnerApplication < ActiveRecord::Migration
  def up
    change_table :community_partner_applications do |t|
      t.remove :how_align, :art_theme, :education_theme, :finance_theme, :health_theme, :public_policy_theme, :social_theme, :technology_theme, :other_theme
      t.string :facebook_page, :null => false
      t.string :twitter_handle, :null => false
      t.string :contact_name, :null => false
      t.string :contact_title, :null => false
      t.string :contact_phone, :null => false
      t.boolean :previous_partner, :null => false
      t.text :why_partner, :null => false
      t.boolean :design_with_purpose_theme, :null => true
      t.boolean :start_something_theme, :null => true
      t.boolean :fashion_theme, :null => true
      t.boolean :sports_theme, :null => true
      t.boolean :cities_theme, :null => true
      t.boolean :politics_theme, :null => true
      t.boolean :philanthropy_theme, :null => true
      t.boolean :tech_theme, :null => true
      t.boolean :breathroughs_in_science_theme, :null => true
      t.boolean :creative_process_theme, :null => true
      t.boolean :health_wellness_theme, :null => true
      t.boolean :future_of_news_theme, :null => true
      t.boolean :influence_of_art_theme, :null => true
      t.boolean :food_theme, :null => true
      t.boolean :good_evil_theme, :null => true
      t.boolean :social_entrepreneurship_theme, :null => true
      t.boolean :explorers_theme, :null => true
      t.boolean :disruptive_innovation_theme, :null => true
      t.boolean :future_of_military_theme, :null => true
      t.boolean :music_theme, :null => true
      t.boolean :religion_theme, :null => true
      t.boolean :epic_friendships_theme, :null => true
      t.boolean :economy_theme, :null => true
      t.boolean :future_leaders_theme, :null => true
      t.boolean :education_theme, :null => true
      t.boolean :meaning_of_life_theme, :null => true
      t.boolean :environment_theme, :null => true
      t.boolean :criminal_justice_theme, :null => true
      t.boolean :storytellers_theme, :null => true
      t.boolean :gender_theme, :null => true
      t.string :most_important
      t.boolean :organization_has_newsletter, :null => true
      t.string :organization_newsletter_frequency
      t.boolean :ciw_updates_in_newsletter, :null => true
      t.boolean :will_promote_ciw
      t.boolean :encourage_promote_ciw
      t.boolean :provide_insight_guidance
    end
  end
  def down
    change_table :community_partner_applications do |t|
      t.remove :facebook_page, :twitter_handle, :contact_name, :contact_title, :previous_partner, :why_partner, :design_with_purpose_theme, :start_something_theme, :fashion_theme, :sports_theme, :politics_theme, :philanthropy_theme, :tech_theme, :breathroughs_in_science_theme, :creative_process_theme, :health_wellness_theme, :future_of_news_theme, :influence_of_art_theme, :food_theme, :good_evil_theme, :social_entrepreneurship_theme, :explorers_theme, :disruptive_innovation_theme, :future_of_military_theme, :music_theme, :religion_theme, :epic_friendships_theme, :economy_theme, :future_leaders_theme, :education_theme, :meaning_of_life_theme, :environment_theme, :criminal_justice_theme, :storytellers_theme, :gender_theme, :most_important, :organization_has_newsletter, :organization_newsletter_frequency, :ciw_updates_in_newsletter, :will_promote_ciw, :encourage_promote_ciw, :provide_insight_guidance
      t.text :how_align
      t.boolean :art_theme
      t.boolean :education_theme
      t.boolean :finance_theme
      t.boolean :public_policy_theme
      t.boolean :health_theme
      t.boolean :social_theme
      t.boolean :technology_theme
      t.string :other_theme
    end
  end
end
