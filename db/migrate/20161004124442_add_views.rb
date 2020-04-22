class AddViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :ip_address
      t.integer :user_id
      t.integer :view_type_id
      t.timestamps :null => false
    end
  end
end
