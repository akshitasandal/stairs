class CreateBlogPostsPostCategories < ActiveRecord::Migration
  def change
    create_table :blog_posts_post_categories do |t|
    	t.integer :blog_post_id
    	t.integer :post_category_id
      t.timestamps null: false
    end
  end
end
