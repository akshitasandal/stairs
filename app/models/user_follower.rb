class UserFollower < ActiveRecord::Base
  scope :followers_count, ->(user_id) { where(:user_id => user_id,:followed => 1 ).count  }
  # scope :bookmarks_count, ->(user_id) { where(:company_id => user_id,:bookmarked => 1 ).count  }
  belongs_to :user
  # belongs_to :company
  
  # Function to make entry for follow
  def self.follow(data)
    if UserFollower.where(:user_id => data[:user_id],:follow_user_id => data[:follow_user_id]).blank?
      follower = UserFollower.new(data)
      follower.save
    else
      UserFollower.where(:user_id => data[:user_id],:follow_user_id => data[:follow_user_id]).update_all(:followed => 1)
    end      
  end
  
  # Function to make entry for unfollow
  def self.unfollow(data)
    status = UserFollower.where(data).update_all(:followed => 0)
  end
  
  
  # # Function to make entry for bookmark
  # def self.bookmark(data)
  #   if UserFollower.where(:user_id => data[:user_id],:company_id => data[:company_id]).blank?
  #     follower = CompanyFollower.new(data)
  #     follower.save
  #   else
  #     UserFollower.where(:user_id => data[:user_id],:company_id => data[:company_id]).update_all(:bookmarked => 1)
  #   end      
  # end
  
  # # Function to make entry for bookmarked
  # def self.bookmarked(data)
  #   status = UserFollower.where(data).update_all(:bookmarked => 0)
  # end
    
  #get all followed company 
  # controller User
  # Params = user_id,params
   def self.followed_users(user_id,params)
    @followed = UserFollower.where(:follow_user_id => user_id,:followed => 1 ).paginate(:page => params[:page] )
  end
  
  #get all followed company 
  # controller User
  # Params = user_id,params
  def self.bookmarked_companies(user_id,params)
    @followed = UserFollower.where(:user_id => user_id,:bookmarked => 1 ).paginate(:page => params[:page] )
  end
end
