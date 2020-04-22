class AddUserNameSlug < ActiveRecord::Migration
  def change
    add_column :users, :username, :text, :after => :last_name
  end
end
