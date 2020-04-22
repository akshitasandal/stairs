class RenameFollowStatus < ActiveRecord::Migration
  
  def change
    rename_column :company_followers, :status, :followed 
  end
  
end
