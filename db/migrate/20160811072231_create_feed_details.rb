class CreateFeedDetails < ActiveRecord::Migration
  def change
    create_table :feed_details do |t|
      t.integer :feed_id
      t.string :video_type
      t.string :video_embed_url
      t.timestamps :null => false
    end
  end
end
