# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User,"ユーザーモデルに関するテスト",type: :model do
  
  describe 'ユーザー新規登録' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.user(:user)).to be_valid
    end
  end
end