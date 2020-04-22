class CreateCompanyFollowers < ActiveRecord::Migration
  def change
    create_table :company_followers do |t|
      t.integer :company_id
      t.integer :user_id
      t.boolean :status
      t.timestamps :null => false
    end
  end
end
