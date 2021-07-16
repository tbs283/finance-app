# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blog, type: :model do
  before do
    @blog = FactoryBot.build(:blog)
  end

  describe 'ブログの新規登録' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:blog)).to be_valid
    end
  end
end