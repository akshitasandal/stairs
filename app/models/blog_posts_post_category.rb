class BlogPostsPostCategory < ActiveRecord::Base
	belongs_to :blog_post
	belongs_to :post_category
end
