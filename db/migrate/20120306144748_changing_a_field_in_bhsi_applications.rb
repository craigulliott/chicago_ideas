class ChangingAFieldInBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :dagreement_accepeted, :boolean, :null => false
    end
  end
end
