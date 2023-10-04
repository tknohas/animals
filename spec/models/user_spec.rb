require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  it "名前、メールアドレス、パスワードがあれば有効な状態であること" do
    expect(user).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    user.username = nil
    user.valid?
    expect(user.errors[:username]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user.email = nil
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効な状態であること" do
    user.password = nil
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    create(:user, email: "test@example.com")
    user.email = "test@example.com"
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "パスワードが6文字未満なら無効な状態であること" do
    user.password = "test1"
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
end
