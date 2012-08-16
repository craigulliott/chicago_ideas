class RenameInstitutionsThinkChicago < ActiveRecord::Migration

  def self.up
    rename_column :think_chicago_applications, :undergraduate_institutions, :institutions
  end

  def self.down
    rename_column :think_chicago_applications, :institutions, :undergraduate_institutions
  end

end
