require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }
  it "tag.nameがあれば有効な状態であること" do
    expect(tag).to be_valid
  end
  it "tag.nameがなければ無効な状態であること" do
    tag.name = nil
    expect(tag).to_not be_valid
  end
end
