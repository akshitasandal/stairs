class CreateUserFollowers < ActiveRecord::Migration
  def change
    create_table :user_followers do |t|
      t.integer :company_id
      t.integer :user_id
      t.boolean :followed
      t.boolean :bookmarked

      t.timestamps null: false
    end
  end
end
