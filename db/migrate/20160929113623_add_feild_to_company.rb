class AddFeildToCompany < ActiveRecord::Migration
  
  #Add Field to company
  def change
    add_column :companies, :overview, :text , :after => :status
    add_column :companies, :size, :integer , :after => :overview
    add_column :companies, :founded, :integer ,  :after => :size
  end
end
