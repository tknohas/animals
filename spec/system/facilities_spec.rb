require 'rails_helper'

RSpec.describe "Facilities", type: :system do
  let!(:facility) { create(:facility, user: user) }
  let(:user) { create(:user) }
  before do
    visit root_path
    click_on "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
  end

  describe "#index" do
    before do
      visit facilities_path
    end
    describe "表示の確認" do
      it "施設名が表示されること" do
        expect(page).to have_content facility.facility_name
      end
      it "紹介文が表示されること" do
        expect(page).to have_content facility.introduction
      end
      it "住所が表示されること" do
        expect(page).to have_content facility.address
      end
      it "作成日が表示されること" do
        expect(page).to have_content facility.created_at.strftime("%Y/%m/%d")
      end
      it "編集ボタンが表示されること" do
        expect(page).to have_content "編集"
      end
      it "削除ボタンが表示されること" do
        expect(page).to have_content "削除"
      end
    end
    describe "リンクの遷移" do
      it "施設名をクリックすると施設の詳細画面に遷移すること" do
        click_on facility.facility_name
        expect(current_path).to eq facility_path(facility.id)
      end
      it "編集ボタンをクリックすると施設の編集画面に遷移すること" do
        click_on "編集"
        expect(current_path).to eq edit_facility_path(facility.id)
      end
    end
    describe "施設の削除", js: true do
      before do
        visit facilities_path
        click_on "削除"
      end
      context "削除ボタンをクリックしOKを選んだ場合" do
        it "施設が削除されること" do
          expect(page.accept_confirm).to eq "削除しますか？"
          expect(page).to have_content "施設が削除されました。"
        end
      end
      context "削除ボタンをクリックしキャンセルを選んだ場合" do
        it "施設が削除されないこと" do
          expect(page.dismiss_confirm).to eq "削除しますか？"
          expect(page).to have_content facility.facility_name
        end
      end
    end
  end
end
