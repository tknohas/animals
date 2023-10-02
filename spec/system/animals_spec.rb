require 'rails_helper'

RSpec.describe "Animals", type: :system do
  let!(:animal) { create(:animal, user: user) }
  let(:user) { create(:user) }
  let!(:female_animal) { create(:animal, user: user, male_or_female: 1, animalname: "はち") }
  let!(:animals) { create_list(:animal, 10, user: user) }
  before do
    visit root_path
    click_on "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
  end

  describe "#index" do
    before do 
      visit animals_path
    end
    describe "表示の確認" do
      it "ユーザー名が表示されること" do
        expect(page).to have_content animal.user.username
      end
      it "動物名が表示されること" do
        expect(page).to have_content animal.animalname
      end
      it "編集ボタンが表示されること" do
        expect(page).to have_link "編集"
      end
    end
    describe "リンクの遷移" do
      it "ユーザー名をクリックするとユーザー詳細画面へ遷移すること" do
        page.first('.user-btn').click
        expect(current_path).to eq user_path(animal.user.id)
      end
      it "動物名をクリックすると詳細画面へ遷移すること" do
        click_on animal.animalname
        expect(current_path).to eq animal_path(animal.id)
      end
      it "編集画面へ遷移すること" do
        click_on "編集", match: :first
        expect(current_path).to eq edit_animal_path(animal.id)
      end
    end
    describe "ページネーション" do
      before do
        visit animals_path
      end
      describe "表示の確認" do
        it "ページネーションが表示されること" do
          expect(page).to have_css ".pagination"
        end
        it "1ページ目に投稿が9件表示されること" do
          animals[0..8].all? do |animal|
            expect(page.all(".animal-card").count).to eq 9
          end
        end
        it "新着投稿が10件以上表示されないこと" do
          expect(page.all(".animal-card").count).to_not eq 10
        end
      end
      describe "遷移すること" do
        it "2をクリックすると2ページ目へ遷移すること" do
          click_on "2"
          expect(current_path).to eq "/animals/page/2"
        end
        it "1をクリックすると1ページ目へ遷移すること" do
          click_on "2"
          click_on "1"
          expect(current_path).to eq "/animals"
        end
      end
    end
  end

  describe "#new" do
    before do 
      visit new_animal_path
    end
    describe "表示の確認" do
      it "動物名の入力フォームが表示されること" do
        expect(page).to have_field 'animal[animalname]'
      end
      it "投稿内容の入力フォームが表示されること" do
        expect(page).to have_field 'animal[body]'
      end
      it "投稿画像の選択フォームが表示されること" do
        expect(page).to have_field 'animal[animal_images][]'
      end
      it "性別のセレクトボックスが表示されること" do
        expect(page).to have_field 'animal[male_or_female]'
      end
      it "カテゴリーの入力フォームが表示されること" do
        expect(page).to have_field 'animal[category]'
      end
      it "保存ボタンが表示されること" do
        expect(page).to have_button '保存'
      end
      it "戻るボタンが表示されること" do
        expect(page).to have_link '戻る'
      end
      it "新規投稿と表示されること" do
        expect(page).to have_content '新規投稿'
      end
    end
    describe '投稿する' do
      it "投稿が完了すること" do
        fill_in "ペットのおなまえ", with: animal.animalname
        fill_in "投稿内容", with: animal.body
        select "メス"
        fill_in "ペットの名称", with: animal.category
        attach_file "写真", "#{Rails.root}/spec/files/attachment.jpg"
        # check 'ネコちゃん'
        click_on "保存"
        expect(page).to have_content '投稿に成功しました。'
      end
      it "投稿に失敗すること" do
        fill_in "ペットのおなまえ", with: ''
        click_on "保存"
        expect(page).to have_content 'errorが発生しています。'
      end
    end
    describe "遷移すること" do
      it '戻るボタンをクリックすると前の画面へ遷移すること' do
        visit root_path
        click_on "ペットの投稿"
        click_on "戻る"
        expect(current_path).to eq root_path
      end
    end
  end
  describe "#show" do
    before do
      visit animal_path(animal.id)
    end
    describe "表示の確認" do
      it "投稿画像が表示されること" do
        expect(page).to have_selector("img[src$='attachment.jpg']")
      end
      it "ペットの名前が表示されること" do
        expect(page).to have_content animal.animalname
      end
      it "投稿内容が表示されること" do
        expect(page).to have_content animal.body
      end
      it "編集ボタンが表示されること" do
        expect(page).to have_link "編集"
      end
      it "削除ボタンが表示されること" do
        expect(page).to have_link "削除"
      end
      describe "性別が表示されること" do
        context "オスの場合" do
          it "「くん」と表示されること" do
            expect(page).to have_content "くん"
          end
        end
        context "メスの場合" do
          it "「ちゃん」と表示されること" do
            visit animal_path(female_animal.id)
            expect(page).to have_content "ちゃん"
          end
        end
      end
    end
    describe "リンクの遷移" do
      it "ペットの一覧画面へ遷移すること" do
        click_on "ペットのみんなへ"
        expect(current_path).to eq animals_path
      end
      it "編集画面へ遷移すること" do
        click_on "編集"
        expect(current_path).to eq edit_animal_path(animal.id)
      end
    end
    describe "投稿の削除", js: true do
      before do
        click_on "削除"
      end
      context "削除ボタンをクリックしOKを選んだ場合" do
        it "投稿が削除されること" do
          expect(page.accept_confirm).to eq "削除しますか？"
          expect(page).to have_content "投稿が削除されました。"
        end
      end
      context "削除ボタンをクリックしキャンセルを選んだ場合" do
        it "投稿が削除されないこと" do
          expect(page.dismiss_confirm).to eq "削除しますか？"
          expect(page).to have_content animal.animalname
        end
      end
    end
  end
  describe "#edit" do
    before do
      visit edit_animal_path(animal.id)
    end
    describe "表示の確認" do
      it "動物名の入力フォームが表示されること" do
        expect(page).to have_field 'animal[animalname]', with: animal.animalname
      end
      it "投稿内容の入力フォームが表示されること" do
        expect(page).to have_field 'animal[body]', with: animal.body
      end
      it "投稿画像の選択フォームが表示されること" do
        expect(page).to have_field 'animal[animal_images][]'
      end
      it "性別のセレクトボックスが表示されること" do
        expect(page).to have_field 'animal[male_or_female]', with: animal.male_or_female
      end
      it "カテゴリーの入力フォームが表示されること" do
        expect(page).to have_field 'animal[category]', with:animal.category
      end
      it "保存ボタンが表示されること" do
        expect(page).to have_button '保存'
      end
      it "戻るボタンが表示されること" do
        expect(page).to have_link '戻る'
      end
      it "投稿の編集と表示されること" do
        expect(page).to have_content '投稿の編集'
      end
    end
    describe '編集する' do
      it "更新が完了すること" do
        fill_in "ペットのおなまえ", with: animal.animalname
        fill_in "投稿内容", with: animal.body
        select "メス"
        fill_in "ペットの名称", with: animal.category
        attach_file "写真", "#{Rails.root}/spec/files/attachment.jpg"
        # check 'ネコちゃん'
        click_on "保存"
        expect(page).to have_content '更新に成功しました。'
      end
      it "更新に失敗すること" do
        fill_in "ペットのおなまえ", with: ''
        click_on "保存"
        expect(page).to have_content 'errorが発生しています。'
      end
    end
    describe "不正なアクセス" do
      before do
        click_on "ログアウト"
        click_on "ゲストログイン"
      end
      it "" do
        visit edit_animal_path(animal.id)
        expect(page).to have_content "不正なアクセスです"
      end
    end
  end
  describe "#search" do
    before do
      visit root_path
    end
    it "探すボタンを押下すると検索結果へ遷移すること" do
      click_on "探す"
      expect(current_path).to eq animals_search_path
    end
    it "categoryで検索すると対象の動物が表示されること" do
      fill_in "keyword", with: animal.category
      click_on "探す"
      expect(page).to have_content animal.animalname
      expect(page).to have_content animal.category
      expect(page).to have_selector("img[src$='attachment.jpg']")
    end
    it "animalnameで検索すると対象の動物が表示されること" do
      fill_in "keyword", with: animal.animalname
      click_on "探す"
      expect(page).to have_content animal.animalname
      expect(page).to have_content animal.category
      expect(page).to have_selector("img[src$='attachment.jpg']")
    end
    it "keywordではない文字を入力すると検索結果が表示されないこと" do
      fill_in "keyword", with: "動物"
      click_on "探す"
      expect(page).to have_content "0件"
      expect(page).to_not have_content animal.animalname
      expect(page).to_not have_content animal.category
      expect(page).to_not have_selector("img[src$='attachment.jpg']")
    end
  end
end
