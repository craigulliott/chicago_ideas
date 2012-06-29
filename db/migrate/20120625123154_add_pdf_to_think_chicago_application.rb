class AddPdfToThinkChicagoApplication < ActiveRecord::Migration
  def change
    change_table :think_chicago_applications do |t|
      t.has_attached_file :pdf
    end
  end
end
