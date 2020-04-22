class WeeklyNewsletter < ApplicationMailer
	def newsletter_email(user)
    @user = user
    @popular_posts = BlogPost.select("blog_posts.*, count(views.object_id) views_count")
                                    .joins("LEFT JOIN views ON views.object_id = blog_posts.id WHERE blog_posts.deleted = 0
                                     AND blog_posts.publish = 1 GROUP BY blog_posts.id ORDER BY views_count DESC" )
                                    .limit(4)
    mail(:to => @user.email, subject: "Latest Listings", from: 'no-reply@mywebsite.com')
  end
end
