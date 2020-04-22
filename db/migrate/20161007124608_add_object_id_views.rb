class AddObjectIdViews < ActiveRecord::Migration
  def change
    add_column :views, :object_id, :integer , :after => :view_type_id
  end
end
