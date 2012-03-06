class AlteringAFieldToBhsiApplications < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :press_clipping_1, :string, :null => true
      t.change :press_clipping_2, :string, :null => true
      t.change :press_clipping_3, :string, :null => true
      t.change :distinguish_yourself, :text, :null => false
      t.integer :agreement_accepeted, :null => false
    end
  end
end
