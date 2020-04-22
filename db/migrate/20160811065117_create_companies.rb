class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, :null => false
      t.integer :functional_area_id, :null => false
      t.string :owner_name, :null => false
      t.integer :user_id # id of user who created company
      t.string :website
      t.string :slug
      t.string :primary_email
      t.string :secondary_email
      t.string :primary_contact_number
      t.string :secondary_contact_number
      t.string :contact_person
      t.integer :state_id
      t.string :city
      t.text :address
      t.boolean :verified
      t.boolean :status #active or blocked
      t.timestamps :null => false
    end
  end
end
