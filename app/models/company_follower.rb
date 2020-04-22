class CompanyFollower < ActiveRecord::Base
  scope :followers_count, ->(company_id) { where(:company_id => company_id,:followed => 1 ).count  }
  scope :bookmarks_count, ->(company_id) { where(:company_id => company_id,:bookmarked => 1 ).count  }
  belongs_to :user
  belongs_to :company
  
  # Function to make entry for follow
  def self.follow(data)
    if CompanyFollower.where(:user_id => data[:user_id],:company_id => data[:company_id]).blank?
      follower = CompanyFollower.new(data)
      follower.save
    else
      CompanyFollower.where(:user_id => data[:user_id],:company_id => data[:company_id]).update_all(:followed => 1)
    end      
  end
  
  # Function to make entry for unfollow
  def self.unfollow(data)
    status = CompanyFollower.where(data).update_all(:followed => 0)
  end
  
  
  # Function to make entry for bookmark
  def self.bookmark(data)
    if CompanyFollower.where(:user_id => data[:user_id],:company_id => data[:company_id]).blank?
      follower = CompanyFollower.new(data)
      follower.save
    else
      CompanyFollower.where(:user_id => data[:user_id],:company_id => data[:company_id]).update_all(:bookmarked => 1)
    end      
  end
  
  # Function to make entry for bookmarked
  def self.bookmarked(data)
    status = CompanyFollower.where(data).update_all(:bookmarked => 0)
  end
    
  #get all followed company 
  # controller User
  # Params = user_id,params
   def self.followed_companies(user_id,params)
    @followed = CompanyFollower.where(:user_id => user_id,:followed => 1 ).paginate(:page => params[:page] )
  end
  
  #get all followed company 
  # controller User
  # Params = user_id,params
  def self.bookmarked_companies(user_id,params)
    @followed = CompanyFollower.where(:user_id => user_id,:bookmarked => 1 ).paginate(:page => params[:page] )
  end
end
