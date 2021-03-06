require 'rails_helper'

describe '目標のテスト' do
  let!(:user) { create(:user, name:'test',email: "test@test",password:'111111',password_confirmation:"111111") }
  let!(:goal) { create(:goal, user_id: user.id,goal_amount:100000) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  
  describe '目標設定画面(new_goal_path)のテスト' do
    before do
      visit new_goal_path
    end
    context '表示の確認' do
      it "blogの投稿フォームが表示されているか" do
        expect(page).to have_field 'goal[goal_amount]'
      end
      it '登録ボタンが表示されているか' do
        expect(page).to have_button '登録'
      end
      it 'new_goal_pathが"/goals/new"であるか' do
        expect(current_path).to eq('/goals/new')
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'goal[goal_amount]', with: Faker::Lorem.characters(number:5)
        click_button '登録'
        expect(page).to have_current_path root_path
      end
    end
  end

  describe '目標編集画面(edit_goal_path)のテスト' do
    before do
      visit edit_goal_path(goal)
    end
    context '表示の確認' do
      it 'edit_goal_pathが"/goals/:id/edit"であるか' do
        expect(current_path).to eq '/goals/' + goal.id.to_s + '/edit'
      end
      it '編集前の目標金額がフォームに表示(セット)されている' do
        expect(page).to have_field 'goal[goal_amount]', with: goal.goal_amount
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'goal[goal_amount]', with: Faker::Lorem.characters(number:5)
        click_button '保存'
        expect(page).to have_current_path mypage_path
      end
    end
  end
end