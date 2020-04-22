class RemoveTagIdFromBlogPosts < ActiveRecord::Migration
  def change
    remove_column :blog_posts, :tag_id, :integer
  end
end
