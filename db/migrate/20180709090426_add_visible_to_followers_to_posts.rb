class AddVisibleToFollowersToPosts < ActiveRecord::Migration
  def change
  	add_column :blog_posts , :visible_to_followers , :boolean
  end
end
