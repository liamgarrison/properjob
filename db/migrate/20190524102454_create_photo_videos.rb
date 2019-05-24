class CreatePhotoVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_videos do |t|
      t.integer :stage
      t.references :job, foreign_key: true
      t.string :photo_url

      t.timestamps
    end
  end
end
