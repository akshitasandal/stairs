class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :deleted , :default => 0
      t.timestamps null: false
    end
  end
end
