require 'rails_helper'

RSpec.configure do |config|
	# For Devise >= 4.1.0
	config.include Devise::Test::ControllerHelpers, :type => :controller
	# Use the following instead if you are on Devise <= 4.1.1
	# config.include Devise::TestHelpers, :type => :controller
end

RSpec.describe PostCategoriesController, type: :controller do
  describe "GET #index" do
	    subject { get :index }

	    it "renders the Companies index template" do
	      expect(subject).to render_template(:index)
	      expect(subject).to render_template("index")
	      expect(subject).to render_template("post_categories/index")
	    end

	    it "does not render a different template" do
	      expect(subject).to_not render_template("post_categories/show")
	    end

	    it "does not render a new post category template" do
	      expect(subject).to_not render_template("post_categories/new")
	    end
  
  	end
end

RSpec.describe Admin::PostCategoriesController, type: :controller do
  	describe "POST #create" do
	  	it "creates post category" do 
		  expect { post :create, :post_category => FactoryBot.create(:post_category) }.to change(PostCategory, :count).by(1) 
		end
	end

	describe "PATCH #update" do
		context "with good data" do
			it "updates the post category and redirects" do
				category = FactoryBot.create(:post_category)
				patch :update, id: category.id, post_category: {  :name => "Gamesss"}
				expect(response).to be_redirect
			end
		end
	end
	describe 'DELETE #destroy' do
		context "success" do
			it "deletes the PostCategory" do
			  expect{ 
				post_category = FactoryBot.create(:post_category)
			    delete :destroy, :id => post_category.id, :company => {:status=> false}
			 }.to change(PostCategory, :count).by(1)
			end
  		end
	end
end
