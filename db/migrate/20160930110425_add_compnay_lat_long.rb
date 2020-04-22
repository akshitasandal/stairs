class AddCompnayLatLong < ActiveRecord::Migration
  #ADD Latitude and Longitude in Company Table
  def change
    add_column :companies, :latitude, :integer , :after => :founded
    add_column :companies, :longitude, :integer , :after => :latitude
  end
end
