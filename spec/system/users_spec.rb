require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)
    visit root_path
    click_on "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
  end
  describe "新規登録、ログイン" do
    before do 
      click_on "ログアウト"
    end
    it "新規登録する" do
      click_on "登録する"
      fill_in "名前", with: "花子"
      fill_in "Eメール", with: "test@rspec.com"
      fill_in "パスワード", with: "test1212"
      fill_in "パスワード（確認用）", with: "test1212"
      click_on "新規登録"
      expect(page).to have_content "アカウント登録が完了しました。"
    end
    it "ログインする" do
      click_on "ログイン"
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_on "ログインする"
      expect(page).to have_content "ログインしました。"
    end
  end
  it "ログアウトする" do
    click_on "ログアウト"
    expect(page).to have_content "ログアウトしました。"
  end
  
  describe "#index" do
    before do 
      visit users_path
    end
    describe "表示の確認" do
      it "usernameが表示されること" do
        expect(page).to have_content user.username
      end
      it "user_imageが表示されること" do
        click_on "プロフィール設定"
        attach_file "user[user_image]", "#{Rails.root}/spec/files/attachment.jpg"
        click_on "編集を完了する"
        visit root_path
        expect(page).to have_selector("img[src$='attachment.jpg']")
      end
    end
    it "ユーザー詳細画面へ遷移すること" do
      within ".users-card" do
        click_on user.username
        expect(current_path).to eq user_path(user.id)
      end
    end
  end
  describe "#show" do
    before do
      visit user_path(user.id)
    end
    describe 
  end
end
