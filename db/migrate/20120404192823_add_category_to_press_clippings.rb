class AddCategoryToPressClippings < ActiveRecord::Migration
  def change
    add_column :press_clippings, :news_type, :string
  end
end
