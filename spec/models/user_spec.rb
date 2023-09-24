require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it "is valid with username, email and password" do
    user = User.new(
      username: "ロロノア",
      email: "greatestsamurai@gmail.com",
      password: "121212"
    )
    expect(user).to be_valid
  end
  it "名前がなければ無効な状態であること" do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("を入力してください")
  end
  it "メールアドレスがなければ無効な状態であること"
  it "重複したメールアドレスなら無効な状態であること"
  it "ユーザーのフルネームを文字列として返すこと"
end
