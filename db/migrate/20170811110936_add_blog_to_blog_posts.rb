class AddBlogToBlogPosts < ActiveRecord::Migration
  def change
  	add_column :blog_posts, :blog_id, :integer
  end
end
