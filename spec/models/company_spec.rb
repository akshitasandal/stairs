require 'rails_helper'

RSpec.describe Company do
  	# pending "add some examples to (or delete) #{__FILE__}"

 	# it "company validations" do
 	# 	# is_expected.to validate_presence_of(:website)
 	# 	is_expected.to validate_uniqueness_of(:website)
 	# end

	it "is not valid without name" do
	  	company = Company.new(name: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without functional_area_id" do
	  	company = Company.new(functional_area_id: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without owner name" do
	  	company = Company.new(owner_name: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without primary_contact_number" do
	  	company = Company.new(primary_contact_number: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without secondary_contact_number" do
	  	company = Company.new(secondary_contact_number: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without contact_person" do
	  	company = Company.new(contact_person: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without state_id" do
	  	company = Company.new(state_id: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without city_id" do
	  	company = Company.new(city_id: nil)
	  	expect(company).to_not be_valid
	end
  	
  	it "is not valid without primary_email" do
	  	company = Company.new(primary_email: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without secondary_email" do
	  	company = Company.new(secondary_email: nil)
	  	expect(company).to_not be_valid
	end

	it "is not valid without website" do
	  	company = Company.new(website: nil)
	  	expect(company).to_not be_valid
	end

	it "assigns default verified status" do
		company = Company.new(:verified => "1")
		expect(company.verified).to eq(true)
    end

    it "assigns default status" do
		company = Company.new(:status => "1")
		expect(company.status).to eq(true)
    end
end

