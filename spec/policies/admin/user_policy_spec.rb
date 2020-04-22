
require 'rails_helper'

describe Admin::UserPolicy do
  subject { described_class.new(user, user) }

  let(:user) { User.create }

  context 'being a visitor' do
    let(:user) { nil }
    it { is_expected.to permit_action(:show) }
  end

  context 'being an super admin' do
    let(:user) { User.create(:id => "1", :email => "abc@gmail.com", :password => "admin123", role_id: "1") }
    it { is_expected.to forbid_actions([:destroy, :index, :create , :edit ,   :new]) }
  end

  context 'being an admin' do
    let(:user) { User.create(:email => "abc@gmail.com", :password => "admin123", role_id: "3") }
    it { is_expected.to forbid_actions([:destroy, :index, :create , :edit , :new]) }
  end
  
end