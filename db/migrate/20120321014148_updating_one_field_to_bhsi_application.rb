class UpdatingOneFieldToBhsiApplication < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.change :agreement_accepeted, :boolean, :null => false, :default => '0'
    end
  end
end
