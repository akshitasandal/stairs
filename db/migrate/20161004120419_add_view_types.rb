class AddViewTypes < ActiveRecord::Migration
  def change
    create_table :view_types do |t|
      t.string :name
      t.boolean :deleted
      t.timestamps :null => false
    end
  end
end
