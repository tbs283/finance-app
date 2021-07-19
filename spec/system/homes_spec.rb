require 'rails_helper'

describe 'ホームのテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:goal) { create(:goal, user: user) }
  let!(:other_goal) { create(:goal, user: other_user) }
  let!(:blog) { create(:blog, user: user) }
  let!(:other_blog) { create(:blog, user: other_user) }
  
  describe 'ホーム画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content blog.title
        expect(page).to have_link blog.title
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
end