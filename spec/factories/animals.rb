FactoryBot.define do
  factory :animal do
    animalname { "ちびた" }
    body { Faker::Lorem.characters(number: 100) }
    category { "柴犬" }
    male_or_female { 1 }
    association :user
  end
end
