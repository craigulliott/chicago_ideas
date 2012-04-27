class AddPdfToVolunteers < ActiveRecord::Migration
  def change
    change_table :volunteers do |t|
      t.has_attached_file :pdf
    end
  end
end
