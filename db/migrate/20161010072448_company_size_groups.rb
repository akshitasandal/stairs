class CompanySizeGroups < ActiveRecord::Migration
  
  def change
    create_table :company_size_groups do |t|
      t.string :size_group
      t.boolean :deleted
      t.timestamps :null => false
    end
  end
  
end

