require "rails_helper"

RSpec.describe User, type: :model do
	let(:user) { User.new }
	
	# it "user validation" do
	# 	# is_expected.to validate_presence_of(:email)
	# 	# is_expected.to validate_presence_of(:password)
	# 	is_expected.to validate_uniqueness_of(:email).case_insensitive
	# end

	it "creates a user successfully" do
		user = FactoryBot.create(:user, :email => "first_user@gmail.com" , :password => "admin123")
		expect(user.email).to eq("first_user@gmail.com")
		expect(user.valid_password?('admin123')).to be_truthy
	end
	
  	it "is not valid without an email" do
	  	user = User.new(email: nil)
	  	expect(user).to_not be_valid
	end

	it "assigns default role" do
		user = User.new(:role_id => "4")
		expect(user.role_id).to eq('4')
    end
	 	
 	it "assigns default status" do
		user = User.new(:status => '1')
		expect(user.status).to eq(true)
    end
    
    it "assigns default verified status" do
		user = User.new(:verified => "1")
		expect(user.verified).to eq(true)
    end

end

