FactoryBot.define do
  factory :animal do
    animalname { "太郎" }
    body { "黒柴です。" }
    category { "柴犬" }
    association :user
  end
end
