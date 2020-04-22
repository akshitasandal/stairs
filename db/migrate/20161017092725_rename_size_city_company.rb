class RenameSizeCityCompany < ActiveRecord::Migration
  def change
    rename_column :companies, :city, :city_id
    rename_column :companies, :size, :company_size_group_id    
  end
end
