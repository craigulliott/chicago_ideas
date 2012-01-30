class CreateCommunityPartnerApplications < ActiveRecord::Migration
  def change
    create_table :community_partner_applications do |t|
      t.string :name, :null => false
      t.text :description, :null => true
      t.string :address1, :null => false
      t.string :address2, :null => true
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :country, :null => false, :default => 'US'
      t.text :how_align, :null => true
      t.boolean :art_theme, :null => true
      t.boolean :education_theme, :null => true
      t.boolean :finance_theme, :null => true
      t.boolean :health_theme, :null => true
      t.boolean :public_policy_theme, :null => true
      t.boolean :social_theme, :null => true
      t.boolean :technology_theme, :null => true
      t.string :other_theme, :null => true
      t.boolean :public_mailing_list, :null => true
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :community_partner_applications, :user_id
    add_foreign_key :community_partner_applications, :users

  end
end
