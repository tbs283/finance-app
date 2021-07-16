require 'rails_helper'

describe 'ホームのテスト' do
  let!(:blog) { create(:blog, title:'hoge',content:'body') }
  let!(:goal) { create(:goal, goal_amount:'100000') }
  describe 'ホーム画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content blog.title
        expect(page).to have_link blog.title
        expect(page).to have_content goal.goal_amount
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
end