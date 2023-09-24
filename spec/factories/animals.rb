FactoryBot.define do
  factory :animal do
    animalname { "太郎" }
    body { Faker::Lorem.characters(number: 100) }
    category { "柴犬" }
    association :user
  end
end
