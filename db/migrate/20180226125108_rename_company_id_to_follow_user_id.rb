class RenameCompanyIdToFollowUserId < ActiveRecord::Migration
  def change
    rename_column :user_followers, :company_id, :follow_user_id
  end
end
