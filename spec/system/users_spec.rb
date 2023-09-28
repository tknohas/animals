require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)
    visit root_path
  end
  it "ログインする" do
    click_on "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
    expect(page).to have_content "ログインしました。"
  end
  it "ログアウトする" do
    click_on "ゲストログイン"
    click_on "ログアウト"
    expect(page).to have_content "ログアウトしました。"
  end
end
