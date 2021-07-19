# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal,"目標モデルに関するテスト",type: :model do
  
  describe 'バリデーションのテスト' do
    subject { goal.valid? }

    let(:user) { create(:user) }
    let!(:goal) { build(:goal, user_id: user.id) }

    context 'goal_amountカラム' do
      it '空欄でないこと' do
        goal.goal_amount = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Goal.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end