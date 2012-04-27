class CreateBhsiApplications < ActiveRecord::Migration
  def change
    create_table :bhsi_applications do |t|

      t.timestamps
    end
  end
end
