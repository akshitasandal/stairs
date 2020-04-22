
require 'rails_helper'

describe Admin::BlogPostPolicy do
  subject { described_class.new(user, blog_post) }
  let(:company) {Company.create(:id => "1", :user_id =>"3", :name => "abc", :functional_area_id => "1",:owner_name => "owner", :primary_contact_number => "1234567890", :secondary_contact_number => "1234567890", :contact_person => "xyz", :state_id => "1", :city_id => "1",  :primary_email => "first_user@gmail.com", :secondary_email => "second_user@gmail.com", :website => "http://abc.com")}
  let(:blog_post) { BlogPost.create(title: "my post title", user_id: "1", company_id: "1", tags: "abc,def,ghi",body: "Body of the post",  description: "This is my blog post description") }

  context 'being a visitor' do
    let(:user) { nil }
    it { is_expected.to permit_action(:show) }
  end

  context 'being an super admin' do
    let(:user) { User.create(:email => "abc@gmail.com", :password => "admin123", role_id: "1") }
    it { is_expected.to permit_actions([ :destroy, :index, :create , :edit , :update, :new]) }
  end

  # context 'being an admin and is company owner' do
  #   let(:user) { User.create(:id => "2",company_id: "1", :email => "abc@gmail.com", :password => "admin123", role_id: "3") }
  #   it { is_expected.to permit_actions([:edit, :destroy]) }
  # end
  
  context 'being a manager' do
    let(:user) { User.create(:email => "abc@gmail.com",:company_id => "1" ,:password => "admin123", role_id: "2") }
    it { is_expected.to permit_actions([:edit, :destroy]) }
  end
  
  context 'being a user' do
    let(:user) { User.create(:id => "1",:email => "abc@gmail.com", :password => "admin123", role_id: "4") }
    it { is_expected.to permit_actions([:edit, :destroy]) }
  end
  
end