class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :album_id
      t.integer :user_id
      t.boolean :deleted
      t.timestamps :null => false
    end
  end
end
