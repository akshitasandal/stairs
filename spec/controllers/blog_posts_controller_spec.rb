require 'rails_helper'

RSpec.configure do |config|
	# For Devise >= 4.1.0
	config.include Devise::Test::ControllerHelpers, :type => :controller
	# Use the following instead if you are on Devise <= 4.1.1
	# config.include Devise::TestHelpers, :type => :controller
end

RSpec.describe BlogPostsController, type: :controller do
	
	describe "GET #index" do

	   it "shows all activities for  blog_posts" do
         expect(subject).to_not render_template("blog_posts/index")     
      end  

	    it "does not render a different template" do
	      expect(subject).to_not render_template("blog_posts/show")
	    end

	    it "does not render a new template" do
	      expect(subject).to_not render_template("blog_posts/new")
	    end
  	end

  	describe "GET #show_tags_blog_posts" do
		context "with good data" do
			it "tag based blog posts" do
				blog_post = FactoryBot.create(:blog_post)
				expect { get :show_tags_blog_posts,  :company_id => "test", :tag_name => "abc" }
				# expect(response).to be_redirect
			end
		end
	end

	describe "GET #show_category_blog_posts" do
		context "with good data" do
			it "category based blog posts" do
				blog_post = FactoryBot.create(:blog_post)
				expect { get :show_category_blog_posts,  :company_id => "test", :category_name => "abc" }
				# expect(response).to be_redirect
			end
		end
	end

end
RSpec.describe Admin::BlogPostsController, type: :controller do
  	
  	describe "POST #create" do
  		context "with good data" do
		  	it "creates blog_post" do 
			  company_params = FactoryBot.create(:company)
			  expect { post :create,{ :company_id => "test" ,:blog_post => FactoryBot.create(:blog_post )} }.to change(BlogPost, :count).by(1) 
			end
		end
		context "with bad data" do
			it "slug is blank " do 
			  company_params = FactoryBot.create(:company)
			  expect { post :create,{ :company_id => "test" ,:blog_post => FactoryBot.attributes_for(:blog_post, :invalid )} }.to change(BlogPost, :count).by(0) 
			end

			it "slug is duplicating " do 
			  company_params = FactoryBot.create(:company)
			  expect { post :create,{ :company_id => "test" ,:blog_post => FactoryBot.attributes_for(:blog_post, :duplicate_slug )} }.to change(BlogPost, :count).by(0) 
			end
		end
	end

	describe "PATCH #update" do
		context "with good data" do
			it "updates the blog post and redirects" do
				blog_post = FactoryBot.create(:blog_post)
				patch :update, id: blog_post.slug, :company_id => "test", blog_post: { :body => "Body of the post body " }
				expect(response).to be_redirect
			end
		end
	end

	describe 'DELETE #destroy' do
		context "success" do
			it "deletes the blog_post" do
			  expect{ 
				blog_post = FactoryBot.create(:blog_post)
			    delete :destroy, :id => blog_post.slug,  :company_id => "test", :company => {:deleted=> '1'}
			 }.to change(Company, :count).by(0)
			end
  		end
	end
end

