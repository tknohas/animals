require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }
  it "" do
    expect(tag).to be_valid
  end
end
