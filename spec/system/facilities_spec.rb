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

  describe "#new" do
    before do
      visit new_facility_path
    end
    describe "表示の確認" do
      it "施設名の入力フォームが表示されること" do
        expect(page).to have_field 'facility[facility_name]'
      end
      it "施設紹介文の入力フォームが表示されること" do
        expect(page).to have_field 'facility[introduction]'
      end
      it "住所の入力フォームが表示されること" do
        expect(page).to have_field 'facility[address]'
      end
      it "リンクの入力フォームが表示されること" do
        expect(page).to have_field 'facility[link_to_site]'
      end
      it "保存ボタンが表示されること" do
        expect(page).to have_button '保存'
      end
      it "戻るボタンが表示されること" do
        expect(page).to have_link '戻る'
      end
    end
    describe '施設の投稿' do
      it '投稿が完了すること' do
        fill_in "facility[facility_name]", with: facility.facility_name
        fill_in "facility[introduction]", with: facility.introduction
        fill_in "facility[address]", with: facility.address
        fill_in "facility[link_to_site]", with: facility.link_to_site
        click_on "保存"
        expect(page).to have_content "施設の登録に成功しました。"
      end
      it '投稿に失敗すること' do
        fill_in "facility[facility_name]", with: ""
        click_on "保存"
        expect(page).to have_content "errorが発生しています。"
      end
    end
    it "戻るボタンをクリックすると前の画面に遷移すること" do
      visit root_path
      click_on "施設の投稿", match: :first
      click_on "戻る"
      expect(current_path).to eq root_path
    end
  end

  describe "#show" do
    before do
      visit facility_path(facility.id)
    end
    describe "表示の確認" do
      it "facility_nameが表示されること" do
        expect(page).to have_content facility.facility_name
      end
      it "introductionが表示されること" do
        expect(page).to have_content facility.introduction
      end
      it "addressが表示されること" do
        expect(page).to have_content facility.address
      end
      it "link_to_siteが表示されること" do
        expect(page).to have_link facility.link_to_site
      end
      it "編集リンクが表示されること" do
        expect(page).to have_link "編集"
      end
      it "削除リンクが表示されること" do
        expect(page).to have_link "削除"
      end
      it "地図が表示されること" do
        expect(page).to have_css '#map'
      end
    end
    describe "リンクの遷移" do
      it "編集画面へ遷移すること" do
        click_on "編集"
        expect(current_path).to eq edit_facility_path(facility.id)
      end
      it "施設のリンク先へ遷移すること" do
        click_on facility.link_to_site
        expect(current_path).to eq facility.link_to_site
      end
    end
    describe "施設の削除", js: true do
      before do
        visit facility_path(facility.id)
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
    describe "自身が登録していない施設の詳細画面" do
      before do
        click_on "ログアウト"
        click_on "ゲストログイン"
        visit facility_path(facility.id)
      end
      it "編集画面へのリンクが表示されないこと" do
        expect(page).to_not have_link "編集"
      end
      it "削除リンクが表示されないこと" do
        expect(page).to_not have_link "削除"
      end
    end
  end

  describe "#edit" do
    before do
      visit edit_facility_path(facility.id)
    end
    describe "表示の確認" do
      it "施設名の入力フォームが表示されること" do
        expect(page).to have_field 'facility[facility_name]', with: facility.facility_name
      end
      it "施設紹介文の入力フォームが表示されること" do
        expect(page).to have_field 'facility[introduction]', with: facility.introduction
      end
      it "住所の入力フォームが表示されること" do
        expect(page).to have_field 'facility[address]', with: facility.address
      end
      it "リンクの入力フォームが表示されること" do
        expect(page).to have_field 'facility[link_to_site]', with: facility.link_to_site
      end
      it "保存ボタンが表示されること" do
        expect(page).to have_button '保存'
      end
      it "戻るボタンが表示されること" do
        expect(page).to have_link '戻る'
      end
    end
    describe '施設の編集' do
      it '更新が完了すること' do
        fill_in "facility[facility_name]", with: facility.facility_name
        fill_in "facility[introduction]", with: facility.introduction
        fill_in "facility[address]", with: facility.address
        fill_in "facility[link_to_site]", with: facility.link_to_site
        click_on "保存"
        expect(page).to have_content "施設の更新に成功しました。"
      end
      it '更新に失敗すること' do
        fill_in "facility[facility_name]", with: ""
        click_on "保存"
        expect(page).to have_content "errorが発生しています。"
      end
    end
    it "戻るボタンをクリックすると前の画面に遷移すること" do
      visit facilities_path
      click_on "編集"
      click_on "戻る"
      expect(current_path).to eq facilities_path
    end
    describe "不正なアクセス" do
      before do
        click_on "ログアウト"
        click_on "ゲストログイン"
      end
      it "" do
        visit edit_facility_path(facility.id)
        expect(page).to have_content "不正なアクセスです"
      end
    end
  end
end
