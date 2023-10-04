require 'rails_helper'

RSpec.describe Animal, type: :model do
  let(:animal) { build(:animal) }
  it "ペットの名前,投稿内容,カテゴリーがあれば有効な状態であること" do
    expect(animal).to be_valid
  end
  it "名前がなければ無効な状態であること" do
    animal.animalname = nil
    animal.valid?
    expect(animal.errors[:animalname]).to include("を入力してください")
  end
  it "投稿内容がなければ無効な状態であること" do
    animal.body = nil
    animal.valid?
    expect(animal.errors[:body]).to include("を入力してください")
  end
  it "カテゴリーがなければ無効な状態であること" do
    animal.category = nil
    animal.valid?
    expect(animal.errors[:category]).to include("を入力してください")
  end
  it "動物名が20文字以内でなければ無効な状態であること" do
    animal.animalname = Faker::Lorem.characters(number: 21)
    expect(animal).to_not be_valid
  end
  it "投稿内容が140文字以内でなければ無効な状態であること" do
    animal.body = Faker::Lorem.characters(number: 141)
    expect(animal).to_not be_valid
  end
end
