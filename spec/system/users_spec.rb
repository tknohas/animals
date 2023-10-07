require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:users) { create_list(:user, 21) }
  let!(:animal) { create(:animal, user: user) }
  before do
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
    it "ゲストユーザーとしてログインする" do
      click_on "ゲストログイン"
      expect(page).to have_content "ゲストユーザーとしてログインしました。"
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
    describe "", js:true do
      it "ユーザー詳細画面へ遷移すること" do
        visit users_path
        page.first(".users-card").click 
        expect(current_path).to eq user_path(user.id)
      end
    end
    describe "ページネーション" do
      describe "表示の確認" do
        it "ページネーションが表示されること" do
          expect(page).to have_css ".pagination"
        end
        it "1ページ目にユーザーが20件表示されること" do
          users[0..20].all? do |user|
            expect(page.all(".users-card").count).to eq 20
          end
        end
        it "ユーザーが1ページに21件以上表示されないこと" do
          expect(page.all(".users-card").count).to_not eq 21
        end
      end
      describe "遷移すること" do
        it "2をクリックすると2ページ目へ遷移すること" do
          click_on "2"
          expect(current_path).to eq "/users/page/2"
        end
        it "1をクリックすると1ページ目へ遷移すること" do
          click_on "2"
          click_on "1"
          expect(current_path).to eq "/users"
        end
      end
    end
  end
  
  describe "#show" do
    before do
      visit user_path(user.id)
    end
    describe "表示の確認" do
      describe "ユーザー情報が表示されること" do
        it "ユーザー画像が表示されること" do
          click_on "プロフィール設定"
          attach_file "user[user_image]", "#{Rails.root}/spec/files/attachment.jpg"
          click_on "編集を完了する"
          visit root_path
          expect(page).to have_selector("img[src$='attachment.jpg']")
        end
        it "ユーザー名が表示されること" do
          expect(page).to have_content user.username
        end
        it "自己紹介文が表示されること" do
          expect(page).to have_content user.profile
        end
        it "edit_user_pathへのリンクが表示されること" do
          expect(page).to have_css '.edit-user'
        end
      end
      describe "自身の投稿が表示されること" do
        it "ユーザー名が表示されること" do
          expect(page).to have_content user.username
        end
        it "投稿画像が表示されること" do
          expect(page).to have_selector("img[src$='attachment.jpg']")
        end
        it "動物名が表示されること" do
          expect(page).to have_content animal.animalname
        end
        it "edit_animal_pathへ遷移するボタンが表示されること" do
          expect(page).to have_css '.animal-edit-button'
        end
      end
      it "users_pathへの遷移ボタンが表示されること" do
        expect(page).to have_link "ユーザーのみなさん"
      end
      describe "表示されないこと" do
        before do 
          click_on "ログアウト"
          click_on "ゲストログイン"
          visit user_path(1)
        end
        it "編集ボタンが表示されないこと" do
          expect(page).to_not have_link "編集"
        end
      end
    end 
    describe "リンクの遷移" do
      it "投稿をクリックすると投稿詳細画面へ遷移すること" do
        click_on "animal_images"
        expect(current_path).to eq animal_path(animal.id)
      end
      it "投稿内の編集ボタンをクリックするとedit_animal_pathへ遷移すること" do
        within ".card" do
          click_on "編集"
          expect(current_path).to eq edit_animal_path(animal.id)
        end
      end
      it "ユーザーのみなさんをクリックするとusers_pathへ遷移すること" do
        within ".users-link" do
          click_on "ユーザーのみなさん"
          expect(current_path).to eq users_path
        end
      end
    end
  end

  describe "#edit" do
    before do
      visit edit_user_path(user.id)
    end
    describe "表示の確認" do
      it "ユーザー画像の選択フォームが表示されること" do
        expect(page).to have_field 'user[user_image]'
      end
      it "名前の入力フォームが表示されること" do
        expect(page).to have_field 'user[username]', with: user.username
      end
      it "自己紹介の入力フォームが表示されること" do
        expect(page).to have_field 'user[profile]'
      end
      it "保存ボタンが表示されること" do
        expect(page).to have_button '編集を完了する'
      end
      it "user_pathへのリンクが表示されること" do
        expect(page).to have_link 'マイページへ'
      end
    end
    describe 'ユーザーの編集' do
      describe "プロフィール設定の編集" do
        it '更新が完了すること' do
          attach_file "user[user_image]", "#{Rails.root}/spec/files/attachment.jpg"
          fill_in "user[username]", with: user.username
          fill_in "user[profile]", with: user.profile
          click_on "編集を完了する"
          expect(page).to have_content "更新に成功しました。"
        end
        it '更新に失敗すること' do
          fill_in "user[username]", with: ""
          click_on "編集を完了する"
          expect(page).to have_content "errorが発生しています。"
        end
      end
      describe "アカウント設定の編集" do
        before do
          visit edit_user_registration_path
        end
        it "更新が完了すること" do
          fill_in "user[email]", with: user.email
          fill_in "user[password]", with: "test1234"
          fill_in "user[password_confirmation]", with: "test1234"
          fill_in "user[current_password]", with: user.password
          click_on "保存する"
          expect(page).to have_content "アカウント情報を変更しました。"
        end
        it "更新に失敗すること" do
          fill_in "user[email]", with: ''
          click_on "保存する"
          expect(page).to have_content "件のエラーが発生したため user は保存されませんでした。"
        end
      end
    end
    describe "不正なアクセス" do
      before do
        click_on "ログアウト"
        click_on "ゲストログイン"
      end
      it "" do
        visit edit_user_path(user.id)
        expect(page).to have_content "不正なアクセスです"
      end
    end
    it "「マイページへ」をクリックするとuser_pathに遷移すること" do
      click_on "マイページへ"
      expect(current_path).to eq user_path(user.id)
    end
  end
end
