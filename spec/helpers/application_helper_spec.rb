require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it '引数が渡されている場合に正常にタイトルを表示できること' do
      expect(full_title('title')).to eq('title - Our Pets')
    end

    it '引数がnilの場合に正常にタイトルを表示できること' do
      expect(full_title(nil)).to eq('Our Pets')
    end

    it '引数が空の場合に正常にタイトルを表示できること' do
      expect(full_title('')).to eq('Our Pets')
    end

    it '引数が空白の場合に正常にタイトルを表示できること' do
      expect(full_title(' ')).to eq('Our Pets')
    end
  end
end
