class AddFollowBookmarkedfeild < ActiveRecord::Migration
   def change
    add_column :company_followers, :bookmarked, :boolean , :after => :followed
  end

end
