class CreateVideo < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :song_name
      t.string :artist_name
      t.string :producer_name
      t.string :genre
      t.string :video_url
      t.integer :user_id
    end
  end
end

