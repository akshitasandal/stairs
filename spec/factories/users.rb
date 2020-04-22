require 'factory_bot'
FactoryBot.define do
  factory :user do
    first_name "Test"
    last_name "User"
   	sequence(:email) { |n| "test#{n}@example.com" }
    password "please123"
    verified "1"
    status "1"
    role_id "4"

    trait :invalid do
      email nil
    end

    trait :duplicate_email do
      email "test@example.com"
    end
    
  end
end
