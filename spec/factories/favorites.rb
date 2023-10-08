FactoryBot.define do
  factory :favorite do
    association :user
    association :animal
  end
end
