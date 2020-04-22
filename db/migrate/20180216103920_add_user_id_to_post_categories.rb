class AddUserIdToPostCategories < ActiveRecord::Migration
  def change
  	add_column :post_categories , :user_id , :integer
  end
end
