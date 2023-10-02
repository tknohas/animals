FactoryBot.define do
  factory :user do
    username { "太郎" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "test12" }
  end
end
