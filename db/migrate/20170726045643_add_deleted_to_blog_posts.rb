class AddDeletedToBlogPosts < ActiveRecord::Migration
  def change
  	add_column :blog_posts, :deleted, :boolean, :default => 0
  end
end
