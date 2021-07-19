# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User,"ユーザーモデルに関するテスト",type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let(:user) { create(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Goalモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:goals).macro).to eq :has_many
      end
    end
    context 'Balanceモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:balances).macro).to eq :has_many
      end
    end
    context 'Blogモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:blogs).macro).to eq :has_many
      end
    end
  end
end