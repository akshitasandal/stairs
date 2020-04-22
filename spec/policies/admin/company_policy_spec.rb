
require 'rails_helper'

describe Admin::CompanyPolicy do
  subject { described_class.new(user, company) }

  let(:company) { Company.create }

  context 'being a visitor' do
    let(:user) { nil }
    it { is_expected.to permit_action(:search) }
  end

  context 'being an super admin' do
    let(:user) { FactoryBot.create(:user, {role_id: "1", email: "xyz@gmail.com"}) }
    it { is_expected.to permit_actions([:show, :destroy, :index, :create , :edit , :update, :validate_user, :new]) }
  end

  context 'being an admin' do
    let(:user) { FactoryBot.create(:user, {role_id: "3", email: "def@gmail.com"}) }
    it { is_expected.to permit_actions([:show,  :index, :create , :validate_user]) }
  end

  context 'being an admin an has no company' do
    let(:user) { FactoryBot.create(:user, {role_id: "3", email: "ghi@gmail.com"}) }
    it { is_expected.to permit_actions([:new , :validate_user]) }
  end
   
  
end