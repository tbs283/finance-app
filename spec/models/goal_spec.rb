# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal, type: :model do
  before do
    @blog = FactoryBot.build(:goal)
  end

  describe '目標の新規登録' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:goal)).to be_valid
    end
  end
end