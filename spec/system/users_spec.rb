require 'rails_helper'

describe 'ホームのテスト' do
  let!(:goal) { create(:goal, goal_amount:'100000') }
  describe 'ホーム画面(mypage_path)のテスト' do
    before do
      visit mypage_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content goal.goal_amount
      end
      it 'mypage_pathが"/mypage"であるか' do
        expect(current_path).to eq('/mypage')
      end
    end
  end
end