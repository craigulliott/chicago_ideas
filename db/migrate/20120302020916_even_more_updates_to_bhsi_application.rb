class EvenMoreUpdatesToBhsiApplication < ActiveRecord::Migration
  def change
    change_table :bhsi_applications do |t|
      t.text :three_standout_statistics, :null => false
    end
  end
end
