# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blog,"ブログモデルに関するテスト",type: :model do
  
  describe 'バリデーションのテスト' do
    subject { blog.valid? }

    let(:user) { create(:user) }
    let!(:blog) { build(:blog, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        blog.title = ''
        is_expected.to eq false
      end
    end
    
    context 'contentカラム' do
      it '空欄でないこと' do
        blog.content = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Blog.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end