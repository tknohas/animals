require 'rails_helper'

RSpec.describe Facility, type: :model do
  let(:facility) { build(:facility) }
  it "施設名、紹介文、住所があれば有効でな状態あること" do
    expect(facility).to be_valid
  end
  it "施設名がなければ無効な状態であること" do
    facility.facility_name = nil
    expect(facility).to_not be_valid
  end
  it "紹介文がなければ無効な状態であること" do
    facility.introduction = nil
    expect(facility).to_not be_valid
  end
  it "住所がなければ無効な状態であること" do
    facility.address = nil
    expect(facility).to_not be_valid
  end
  it "施設名が20文字以内でなければ無効な状態であること" do
    facility.facility_name = Faker::Lorem.characters(number: 21)
    expect(facility).to_not be_valid
  end
  it "紹介文が140文字以内でなければ無効な状態であること" do
    facility.introduction = Faker::Lorem.characters(number: 141)
    expect(facility).to_not be_valid
  end
end
