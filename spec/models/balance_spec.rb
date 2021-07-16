# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Balance,"収支モデルに関するテスト",type: :model do

  describe '収支の新規登録' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:balance)).to be_valid
    end
  end
end