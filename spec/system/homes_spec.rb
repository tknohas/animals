require 'rails_helper'

RSpec.describe "Homes", type: :system do
  let(:user) { create(:user) }
  let!(:animals) { create_list(:animal, 9, user: user) }
  let!(:tag) { create(:tag) }
  let(:animal) { create(:animal, user: user) }
  let!(:animal_tag) { create(:animal_tag, tag: tag, animal: animal) }
  let!(:other_tag) { create(:tag) }
  before do
    visit root_path
    click_on "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
  end

  describe "nav-bar" do
    describe "nav-barのリンクの遷移" do
      context "ログイン時" do
        it "root_pathへの遷移" do
          find('.navbar-brand').click
          expect(current_path).to eq root_path
        end
        it "new_animal_pathへの遷移" do
          click_on "ペットの投稿", match: :first
          expect(current_path).to eq new_animal_path
        end
        it "new_facility_pathへの遷移" do
          click_on "施設の投稿", match: :first
          expect(current_path).to eq new_facility_path
        end
        it "animals_pathへの遷移" do
          click_on "ペットのみんな", match: :first
          expect(current_path).to eq animals_path
        end
        it "facilities_pathへの遷移" do
          click_on "おすすめ施設", match: :first
          expect(current_path).to eq facilities_path
        end
        it "users_pathへの遷移" do
          click_on "ユーザーのみなさん", match: :first
          expect(current_path).to eq users_path
        end
        it "user_pathへの遷移" do
          click_on "マイページ"
          expect(current_path).to eq user_path(user.id)
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
      it "user_imageが表示されること" do
        visit edit_user_path(user.id)
        attach_file "user[user_image]", "#{Rails.root}/spec/files/attachment.jpg"
        click_on "編集を完了する"
        visit root_path
        expect(page).to have_selector("img[src$='attachment.jpg']")
      end
    end
    describe "退会する", js: true do
      before do
        within ".navbar" do
          click_on user.username
          click_on "退会"
        end
      end
      context "退会をクリックしOKを選んだ場合" do
        it "ユーザーが削除されること" do
          expect(page.accept_confirm).to eq "アカウントを削除してよろしいですか？"
          expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
        end
      end
      context "退会をクリックしキャンセルを選んだ場合" do
        it "ユーザーが削除されないこと" do
          expect(page.dismiss_confirm).to eq "アカウントを削除してよろしいですか？"
          expect(page).to have_content user.username
        end
      end
    end
  end
  describe "body" do
    it "検索フォームが表示されること" do
      expect(page).to have_field "keyword"
      expect(page).to have_button "探す"
    end
    it "ドロップダウンボタンが表示されること" do
      expect(page).to have_content "カテゴリーで絞り込む"
    end
    it "tag.nameが表示されること" do
      expect(page).to have_content tag.name
    end
    it "新着投稿が9件表示されること" do
      animals[0..8].all? do |animal|
        expect(page.all(".animal-card").count).to eq 9
      end
    end
    it "新着投稿が10件以上表示されないこと" do
      expect(page.all(".animal-card").count).to_not eq 10
    end
    describe "tag.nameをクリックする" do
      it "タグに紐づく投稿を取得できること" do
        click_on tag.name
        expect(page).to have_css(".animal-card")
      end
      it "タグに紐づかない投稿は取得しないこと" do
        click_on other_tag.name
        expect(page).to_not have_css(".animal-card")
      end
    end
  end
end
