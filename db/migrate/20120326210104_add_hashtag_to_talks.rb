class AddHashtagToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :twitter_hashtag, :string
  end
end
