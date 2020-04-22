class AddColumnToPostCategories < ActiveRecord::Migration
  def change
    add_column :post_categories, :status, :boolean , :default => 0
  end
end
