require "rails_helper"

RSpec.describe PostCategory do

	# it "should require a fields" do
	#     BlogPost.create(:title => "").should_not be_valid
 # 	end

	it "should remove extra white space when validated" do
	  	post_category = FactoryBot.create(:post_category)
		expect(post_category).to receive(:strip_whitespace)
		post_category.save
	end
end
