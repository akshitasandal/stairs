class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :controller
      t.string :action

      t.timestamps null: false
    end
  end
end
