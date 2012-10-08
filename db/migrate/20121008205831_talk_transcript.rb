class TalkTranscript < ActiveRecord::Migration
  def change
    add_column :talks, :transcript_file_name, :string, :null => true
    add_column :talks, :transcript_content_type, :string, :null => true
    add_column :talks, :transcript_file_size, :integer, :null => true
    add_column :talks, :transcript_updated_at, :datetime, :null => true
  end
end
