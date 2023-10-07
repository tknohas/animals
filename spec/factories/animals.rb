FactoryBot.define do
  factory :animal do
    animalname { "ちびた" }
    body { Faker::Lorem.characters(number: 100) }
    category { "柴犬" }
    male_or_female { 0 }
    association :user

    after(:build) do |animal|
      animal.animal_images.attach(io: File.open('spec/files/attachment.jpg'), filename: 'attachment.jpg',
                                  content_type: 'image/jpg')
    end
  end
end
