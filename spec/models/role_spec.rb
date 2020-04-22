require 'rails_helper'

RSpec.describe Role do
    # pending "add some examples to (or delete) #{__FILE__}"
  	it "is not valid without name" do
	  	company = Company.new(name: nil)
	  	expect(company).to_not be_valid
	end
end
