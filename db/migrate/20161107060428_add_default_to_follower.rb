class AddDefaultToFollower < ActiveRecord::Migration
  def change
    change_column :company_followers, :followed, :boolean, :default => 0
    change_column :company_followers, :bookmarked, :boolean, :default => 0
  end
end
