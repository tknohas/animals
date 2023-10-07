require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  let(:user) { create(:user) }
  let(:animal) { create(:animal) }
  let!(:favorite) { create(:favorite) }
  before do
    visit root_path
    click_on "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
  end

  describe "いいね", js: true do
    before do
      visit animal_path(animal.id)
      find(".favorite-btn").click
    end
    it "いいねできること" do
      expect(page).to have_css ".already-favorite-btn"
    end
    it "いいねを解除できること" do
      find(".already-favorite-btn").click
      expect(page).to have_css ".favorite-btn"
    end
    it "いいねをするといいね一覧に投稿が表示されること" do
      visit user_favorites_path(user.id)
      expect(page).to have_css ".animal-card"
    end
    it "いいねを外すといいね一覧に投稿が表示されないこと" do
      visit user_favorites_path(user.id)
      find(".already-favorite-btn").click
      visit current_path
      expect(page).to_not have_css ".animal-card"
    end
  end
end
