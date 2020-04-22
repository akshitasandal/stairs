class AddColumnToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :publish, :boolean , :default => 0
  end
end
