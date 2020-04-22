class CreateImageLikes < ActiveRecord::Migration
  def change
    create_table :image_likes do |t|
      t.integer :image_id
      t.integer :user_id
      t.boolean :status
      t.timestamps :null => false
    end
  end
end
