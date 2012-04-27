class AddPdfToAffiliateEventApplication < ActiveRecord::Migration
  def change
    change_table :affiliate_event_applications do |t|
      t.has_attached_file :pdf
    end
  end
end
