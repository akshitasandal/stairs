class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title, :null => false
      t.text :content
      t.integer :company_id, :null => false
      t.integer :user_id, :null => false
      t.integer :feed_type, :null => false # 1 - text, 2 - Image, 3 - Video (youtube or vimeo)
      t.timestamps :null => false
    end
  end
end
