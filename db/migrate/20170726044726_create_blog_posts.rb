class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|

      t.string :title
      t.text :description
      t.text :body
      t.string :keywords
      t.attachment :featured_image
      t.integer :tag_id
      t.integer :company_id
      t.integer :post_category_id
      t.timestamps null: false
    end
  end
end
