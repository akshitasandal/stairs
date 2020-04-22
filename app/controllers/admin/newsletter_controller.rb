class Admin::NewsletterController < ApplicationController
	
	def weekly_listings_for_users
		# debugger
  #   weekly_listings = BlogPost.where('deleted = "0" AND (DATE(created_at) = ?)', Date.today - 6)
  #   if weekly_listings.count > 0
  #   	debugger
  #     WeeklyNewsletter.delay.weekly_popular_posts
  #   end  
  #   render :nothing => true
  end

  def unsubscribe

  end

end
