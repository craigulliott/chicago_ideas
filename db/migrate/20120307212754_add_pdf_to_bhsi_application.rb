class AddPdfToBhsiApplication < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.has_attached_file :pdf
    end
  end
end
