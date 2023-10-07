require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:animal) { create(:animal) }
  let(:favorite) { create(:favorite, user_id: user.id, animal_id: animal.id)}
  
  it "user_idとanimal_idがあれば有効な状態であること" do
    expect(favorite).to be_valid
  end
  it "user_idがなければ無効な状態であること" do
    favorite.user_id = nil
    expect(favorite).to_not be_valid
  end
  it "animal_idがなければ無効な状態であること" do
    favorite.animal_id = nil
    expect(favorite).to_not be_valid
  end
end
