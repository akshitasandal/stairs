require "rails_helper"

RSpec.describe BlogPost do
	it "should remove whitespaces when submit" do
		blog_post = FactoryBot.create(:blog_post, slug: "abc")
		expect(blog_post).to receive(:strip_whitespace)
		# expect(blog_post).to receive(:create_slug)
		blog_post.save
	end
end
