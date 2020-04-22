class CreateFunctionalAreas < ActiveRecord::Migration
  def change
    create_table :functional_areas do |t|
      t.string name, :null => false
      t.timestamps :null => false
    end
  end
end
