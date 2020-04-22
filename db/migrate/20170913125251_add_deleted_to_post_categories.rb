class AddDeletedToPostCategories < ActiveRecord::Migration
  def change
    add_column :post_categories, :deleted, :boolean, :default => 0
  end
end
