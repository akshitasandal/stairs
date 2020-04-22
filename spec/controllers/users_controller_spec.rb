require 'rails_helper'



  RSpec.configure do |config|
    # For Devise >= 4.1.0
    config.include Devise::Test::ControllerHelpers, :type => :controller
    # Use the following instead if you are on Devise <= 4.1.1
    # config.include Devise::TestHelpers, :type => :controller
  end

RSpec.describe UsersController, type: :controller do
	describe "GET #index" do
	    # subject { get :index }

	    # it "renders the Users index template" do
	    #   expect(subject).to render_template(:index)
	    #   expect(subject).to render_template("index")
	    #   expect(subject).to render_template("users/index")
	    # end

	    it "does not render a different template" do
	      expect(subject ).to_not render_template("users/show")
	    end

	    it "does not render a new Users template" do
	      expect(subject).to_not render_template("users/new")
	    end
  
  	end
end

RSpec.describe Admin::UsersController, type: :controller do
  	describe "POST #create" do
	  	it "creates user" do 
		  # user_params = { :email => "first_user@gmail.com", :password => "admin123"}
		  expect { post :create, :user => FactoryBot.create(:user) }.to change(User, :count).by(1) 
		end

		it "re-renders the new method" do
		  	expect { post :create, :user => FactoryBot.attributes_for(:user, :invalid) }.to change(User, :count).by(0) 
        end

      	it "re-renders the new method if duplicate website" do
		  	expect { post :create,:user => FactoryBot.attributes_for(:user, :duplicate_email) }.to change(User ,:count).by(0) 
	       	# expect(Company.count).to eq()
        end
	end

	describe "PATCH #update" do
		context "with good data" do
			it "updates the user and redirects" do
				user = FactoryBot.create(:user)
				patch :update, id: user.username, user: { :password => "admin1234"}
				expect(response).to be_redirect
			end
		end
	end
end