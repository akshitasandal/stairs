class AddFieldsToUsers < ActiveRecord::Migration
  def change
    puts "Adding columns to users table"
    change_table :users do |t|
      t.string :first_name, :after => :id
      t.string :last_name, :after => :first_name
      t.text :bio, :after => :last_name
      t.text :skills, :after => :bio
      t.integer :role_id, :after => :skills
      # 0 => not verified 1 => verified
      t.boolean :verified, :after => :role_id, :default => 0
      # 0 => active 1 =>  blocked
      t.boolean :status, :after => :verified, :default => 0
    end
  end
end