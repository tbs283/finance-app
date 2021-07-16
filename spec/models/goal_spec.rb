# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal,"目標モデルに関するテスト",type: :model do
  
  describe '目標の新規登録' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:goal)).to be_valid
    end
  end
end