class AddPdfToCommunityPartnerApplications < ActiveRecord::Migration
  def change
    change_table :community_partner_applications do |t|
      t.has_attached_file :pdf
    end
  end
end
