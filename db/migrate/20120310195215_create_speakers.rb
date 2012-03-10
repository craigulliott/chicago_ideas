class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.integer :year_id
      t.integer :user_id
      t.timestamps 
    end
     User.speaker.each do |spk|
        newSpeaker = Speaker.new()
        newSpeaker.user_id = spk.id
        newSpeaker.year_id = 2011
        newSpeaker.save
      end
  end
end
