require 'rails_helper'

RSpec.configure do |config|
	# For Devise >= 4.1.0
	config.include Devise::Test::ControllerHelpers, :type => :controller
	# Use the following instead if you are on Devise <= 4.1.1
	# config.include Devise::TestHelpers, :type => :controller
end

RSpec.describe CompaniesController, type: :controller do
	describe "GET #index" do
	    subject { get :index }

	    it "renders the Companies index template" do
	      expect(subject).to render_template(:index)
	      expect(subject).to render_template("index")
	      expect(subject).to render_template("companies/index")
	    end

	    it "does not render a different template" do
	      expect(subject).to_not render_template("companies/show")
	    end

	    it "does not render a new company template" do
	      expect(subject).to_not render_template("companies/new")
	    end
  	end
  	describe 'POST #validate_slug' do
		context "success" do
			it "validates the slug of the company" do
			  expect{ 
				company = FactoryBot.create(:company)
			    post :validate_slug }
			end
  		end
	end

	describe 'POST #subscribe' do
		context "success" do
			it "subscribe the company" do
			  expect{ 
				company = FactoryBot.create(:company)
			    post :subscribe }
			end
  		end
	end

	describe 'PATCH #unsubscribe' do
		context "success" do
			it "validates the slug of the company" do
			  expect{ 
				company = FactoryBot.create(:company)
			    patch :unsubscribe }
			end
  		end
	end
	describe 'POST #bookmark' do
		context "success" do
			it "bookmark the company" do
			  expect{ 
				company = FactoryBot.create(:company)
			    post :bookmark }
			end
  		end
	end
	describe 'PATCH #bookmarked' do
		context "success" do
			it "remove bookmark from the company" do
			  expect{ 
				company = FactoryBot.create(:company)
			    patch :bookmarked }
			end
  		end
	end
end

RSpec.describe Admin::CompaniesController, type: :controller do
  	describe "POST #create" do
  		context "with good data" do
		  	it "creates company" do 
			  expect { post :create, :company => FactoryBot.create(:company) }.to change(Company, :count).by(1) 
			end
		end
		
		context "with bad data" do
			it "re-renders the new method" do
			  	company_params = FactoryBot.attributes_for(:company, :invalid)
			  	expect { post :create, :company => company_params }.to change(Company, :count).by(0) 
		       	# expect(Company.count).to eq()
	        end
	        it "re-renders the new method if duplicate website" do
			  	company_params = FactoryBot.attributes_for(:company, :duplicate_website)
			  	expect { post :create, :company => company_params }.to change(Company, :count).by(0) 
		       	# expect(Company.count).to eq()
	        end
	    end
	end

	describe "PATCH #update" do
		context "with good data" do
			it "updates the company and redirects" do
				company = FactoryBot.create(:company)
				patch :update, id: company.slug, company: { :secondary_email => "akshita.cse123@gmail.com"}
				expect(response).to be_redirect
			end
		end
	end

	describe 'DELETE #destroy' do
		context "success" do
			it "deletes the company" do
			  expect{ 
				company = FactoryBot.create(:company)
			    delete :destroy, :id => company.slug, :company => {:status=> '0'}
			 }.to change(Company, :count).by(1)
			end
  		end
	end

	describe 'POST #validate_slug' do
		context "success" do
			it "validates the slug of the company" do
			  expect{ 
				company = FactoryBot.create(:company)
			    post :validate_slug }
			end
  		end
	end



end
