FactoryBot.define do
  factory :facility do
    facility_name { "上野動物園" }
    introduction { "Faker::Lorem.characters(number: 100)" }
    address { "東京都台東区上野公園9-83" }
  end
end
