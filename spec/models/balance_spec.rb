# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Balance, type: :model do
  before do
    @balance = FactoryBot.build(:balance)
  end

  describe '収支の新規登録' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:balance)).to be_valid
    end
  end
end