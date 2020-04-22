class CreateBlogPostImages < ActiveRecord::Migration
  def change
    create_table :blog_post_images do |t|
      t.attachment :blog_post_image
      t.integer :blog_post_id

      t.timestamps null: false
    end
  end
end
