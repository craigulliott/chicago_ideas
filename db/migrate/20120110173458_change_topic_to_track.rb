class ChangeTopicToTrack < ActiveRecord::Migration
  def up
    # we are renaming the "topic" model to "track" and making it optional
    remove_foreign_key :talks, :topics
    change_column :talks, :topic_id, :integer, :null => true
    rename_column :talks, :topic_id, :track_id

    rename_table :topics, :tracks
    
    add_foreign_key :talks, :tracks
  end

  def down
    remove_foreign_key :talks, :tracks
    change_column :talks, :topic_id, :integer, :null => false
    rename_column :talks, :track_id, :topic_id

    rename_table :tracks, :topics
    
    add_foreign_key :talks, :topics
  end
end
