class ChangeRoleIdTypeInUsers < ActiveRecord::Migration
  def change
  	change_column :users , :role_id ,:string

  end
end
