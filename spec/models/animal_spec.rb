require 'rails_helper'

RSpec.describe Animal, type: :model do
  it "animalname,body,categoryがあれば有効な状態であること" do
    expect(FactoryBot.build(:animal)).to be_valid
  end
  it "名前がなければ無効な状態であること" do
    animal = Animal.new(animalname: nil)
    animal.valid?
    expect(animal.errors[:animalname]).to include("を入力してください")
  end
  it "投稿内容がなければ無効な状態であること" do
    animal = Animal.new(body: nil)
    animal.valid?
    expect(animal.errors[:body]).to include("を入力してください")
  end
  it "カテゴリーがなければ無効な状態であること" do
    animal = Animal.new(category: nil)
    animal.valid?
    expect(animal.errors[:category]).to include("を入力してください")
  end
end
