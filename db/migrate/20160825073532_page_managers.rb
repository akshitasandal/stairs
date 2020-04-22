class PageManagers < ActiveRecord::Migration
  def change
    create_table :page_managers do |t|
      t.integer :user_id
      t.integer :company_id
      t.boolean :status
      t.timestamps :null => false
    end
  end
end
