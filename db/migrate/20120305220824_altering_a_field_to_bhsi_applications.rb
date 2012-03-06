class AlteringAFieldToBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :press_clipping_1, :null => true
      t.change :press_clipping_2, :null => true
      t.change :press_clipping_3, :null => true
      t.change :distinguish_yourself, :null => false
      t.integer :agreement_accepeted, :null => false
    end
  end
end
