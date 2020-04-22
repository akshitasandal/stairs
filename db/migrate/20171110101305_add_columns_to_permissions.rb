class AddColumnsToPermissions < ActiveRecord::Migration
  def change
  	add_column :permissions, :role_id, :integer
  	add_column :permissions, :resource_id, :integer
  end
end
