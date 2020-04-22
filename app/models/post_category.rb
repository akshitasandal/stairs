class PostCategory < ActiveRecord::Base
	before_validation :strip_whitespace
	has_many :blog_posts_post_categories
	has_many :blog_posts, :through => :blog_posts_post_categories
	belongs_to :user
	# method to remove white space between tags

	def to_param
		[name.parameterize].join("-")
	end

  def strip_whitespace
    self.name = name.strip
  end


end
