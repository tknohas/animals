require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "is valid with username, email and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    user = FactoryBot.build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効な状態であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: "test@example.com")
    user = FactoryBot.build(:user, email: "test@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "パスワードが6文字未満なら無効な状態であること" do
    user = FactoryBot.build(:user, password: "test1")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
end
