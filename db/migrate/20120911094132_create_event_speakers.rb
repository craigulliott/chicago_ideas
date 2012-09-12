class CreateEventSpeakers < ActiveRecord::Migration
  def change
    # many speakers can be present for an event
    create_table :event_speakers do |t|
      t.integer :speaker_id, :null => false
      t.integer :event_id, :null => false

      t.timestamps
    end

    add_index :event_speakers, [:speaker_id, :event_id], :unique => true
    add_foreign_key :event_speakers, :users, :column => :speaker_id

    add_index :event_speakers, :event_id
    add_foreign_key :event_speakers, :events

  end
end
