class AddPrivateToBlogPosts < ActiveRecord::Migration
  def change
  	add_column :blog_posts , :private , :boolean
  end
end
