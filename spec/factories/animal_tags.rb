FactoryBot.define do
  factory :animal_tag do
    association :animal
    association :tag
  end
end
