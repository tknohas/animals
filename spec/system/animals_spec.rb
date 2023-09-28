require 'rails_helper'

RSpec.describe "Animals", type: :system do
  let!(:animal) { create(:animal) }
  let(:animal1) { create(:animal, male_or_female: 1) }
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)
    visit root_path
    click_on "ゲストログイン"
  end

  describe "一覧画面" do
    before do 
      visit animals_path
      save_and_open_page
    end
    it "ユーザー名が表示されること" do
      expect(page).to have_content animal.user.username
    end
    it "ユーザー名をクリックするとユーザー詳細画面へ遷移すること" do
      click_on animal.user.username
      expect(current_path).to eq user_path(animal.user.id)
    end
    it "動物名が表示されること" do
      expect(page).to have_content animal.animalname
    end
    it "動物名をクリックすると詳細画面へ遷移すること" do
      within ".hoge" do
        click_on animal.animalname
        expect(current_path).to eq animal_path(animal.id)
      end
    end
  end

  describe "新規投稿画面" do
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
      it "投稿ボタンが表示されること" do
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
      it "ペットの名前が表示されること" do
        expect(page).to have_content animal.animalname
      end
      it "投稿内容が表示されること" do
        expect(page).to have_content animal.body
      end
    end
    it "ペットの一覧画面へ遷移すること" do
      click_on "ペットのみんなへ"
      expect(current_path).to eq animals_path
    end
    it "" do
      visit animal_path(animal1.id)
      save_and_open_page
      expect(page).to have_content "くん"
    end
  end
  describe "検索する" do
    it "検索" do
      visit root_path
      fill_in "keyword", with: animal.animalname
      click_on "探す"
      save_and_open_page
      expect(page).to have_content animal.animalname
    end
  end
end
