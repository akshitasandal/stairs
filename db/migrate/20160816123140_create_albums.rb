class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :company_id
      t.boolean :deleted
      t.timestamps :null => false
    end
  end
end
