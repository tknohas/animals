require 'rails_helper'

RSpec.describe "Homes", type: :system do
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)
    visit root_path
    click_on "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
  end
  describe "nav-barのリンクの遷移" do
    context "ログイン時" do
      it "root_pathへの遷移" do
        find('.navbar-brand').click
        expect(current_path).to eq root_path
      end
      it "new_animal_pathへの遷移" do
        click_on "ペットの投稿" 
        expect(current_path).to eq new_animal_path
      end
      it "new_facility_pathへの遷移" do
        click_on "施設の投稿" 
        expect(current_path).to eq new_facility_path
      end
      it "animals_pathへの遷移" do
        click_on "ペットのみんな" 
        expect(current_path).to eq animals_path
      end
      it "facilities_pathへの遷移" do
        click_on "おすすめ施設" 
        expect(current_path).to eq facilities_path
      end
      it "edit_user_registration_pathへの遷移" do
        click_on "アカウント設定" 
        expect(current_path).to eq edit_user_registration_path
      end
      it "edit_user_pathへの遷移" do
        click_on "プロフィール設定" 
        expect(current_path).to eq edit_user_path(user.id)
      end
      it "ログアウト後root_pathへの遷移" do
        click_on "ログアウト" 
        expect(current_path).to eq root_path
      end
    end
    context "ログアウト時" do
      before do 
        click_on "ログアウト"
      end
      it "new_user_registration_pathへの遷移" do 
        click_on "登録する"
        expect(current_path).to eq new_user_registration_path
      end
      it "user_session_pathへの遷移" do 
        click_on "ログイン"
        expect(current_path).to eq new_user_session_path
      end
      it "ゲストログイン押下時にroot_pathへの遷移" do 
        click_on "ゲストログイン"
        expect(current_path).to eq root_path
      end
    end
  end
  describe "user情報の表示" do
    it "usernameが表示されること" do
      expect(page).to have_content user.username
    end
    describe "user_image" do
      before do
        visit edit_user_path(user.id)
        attach_file "user[user_image]", "#{Rails.root}/spec/files/attachment.jpg"
        click_on "編集を完了する"
        visit root_path
      end
      it "user_imageが表示されること" do
        expect(page).to have_selector("img[src$='attachment.jpg']")
      end
    end
  end
end
