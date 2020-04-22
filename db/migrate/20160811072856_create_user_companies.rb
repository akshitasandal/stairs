class CreateUserCompanies < ActiveRecord::Migration
  def change
    create_table :user_companies do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :period
      t.string :designation
      t.string :responsibilities
      t.string :responsibilities
    end
  end
end
