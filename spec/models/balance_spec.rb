# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Balance,"収支モデルに関するテスト",type: :model do
  
  describe 'バリデーションのテスト' do
    subject { balance.valid? }

    let(:user) { create(:user) }
    let!(:balance) { build(:balance, user_id: user.id) }

    context 'amountカラム' do
      it '空欄でないこと' do
        balance.amount = nil
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Balance.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end