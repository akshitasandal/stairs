
require 'rails_helper'

describe Admin::PostCategoryPolicy do
  subject { described_class.new(user, post_category) }

  let(:post_category) { PostCategory.create(:name => "games") }

  context 'being a visitor' do
    
    let(:user) { nil }
    it { is_expected.to permit_actions([ :show ,:new, :create]) }
  end

  context 'being an super admin' do
    let(:user) { User.create(:email => "abc@gmail.com", :password => "admin123", role_id: "1") }
    it { is_expected.to permit_actions([:destroy,:index , :edit]) }
  end
  
end