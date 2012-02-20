class UpdateFieldsToCommunityPartnerApplication < ActiveRecord::Migration
  def up
    change_table :community_partner_applications do |t|      
      t.string :contact_email, :null => false
      t.change :facebook_page, :string, {:null => true}
      t.change :twitter_handle, :string, {:null => true}
      t.change :will_promote_ciw, :boolean, {:null => false}
      t.change :encourage_promote_ciw, :boolean, {:null => false}
      t.change :provide_insight_guidance, :boolean, {:null => false}
    end
  end

  def down
    change_table :community_partner_applications do |t|      
      t.remove :contact_email
      t.change :facebook_page, :string, {:null => false}
      t.change :twitter_handle, :string, {:null => false}
      t.change :will_promote_ciw, :boolean, {:null => true}
      t.change :encourage_promote_ciw, :boolean, {:null => true}
      t.change :provide_insight_guidance, :boolean, {:null => true}
    end
  end
end
