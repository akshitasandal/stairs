class BlogPostImage < ActiveRecord::Base
	belongs_to :blog_post 
	has_attached_file :blog_post_image , styles: { :medium => "230x157#", :small => "100x100" }
	validates_attachment_content_type :blog_post_image , :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
