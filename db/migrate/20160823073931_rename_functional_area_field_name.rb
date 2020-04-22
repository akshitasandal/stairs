class RenameFunctionalAreaFieldName < ActiveRecord::Migration
   def change
    change_table :functional_areas do |t|
      t.rename :CreateFunctionalAreas, :name
    end
  end
end
