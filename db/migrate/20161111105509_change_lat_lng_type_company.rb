class ChangeLatLngTypeCompany < ActiveRecord::Migration
  def change
    change_column :companies, :latitude, :text
    change_column :companies, :longitude, :text
  end
end