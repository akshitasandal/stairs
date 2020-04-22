class CreateFeedLikes < ActiveRecord::Migration
  def change
    create_table :feed_likes do |t|
      t.integer :feed_id
      t.integer :user_id
      t.boolean :status
      t.timestamps :null => false
    end
  end
end
