require 'rails_helper'

describe 'ユーザーのテスト' do
  let!(:user) { create(:user, name:'test',email: "test@test",password:'111111',password_confirmation:"111111") }
  let!(:other_user) { create(:user) }
  let!(:goal) { create(:goal, user: user) }
  let!(:other_goal) { create(:goal, user: other_user) }
  let!(:blog) { create(:blog, user: user) }
  let!(:other_blog) { create(:blog, user: other_user) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  
  describe 'マイページ画面(mypage_path)のテスト' do
    before do
      visit mypage_path
    end
    context '表示の確認' do
      it 'mypage_pathが"/mypage"であるか' do
        expect(current_path).to eq('/mypage')
      end
    end
  end
  
  describe "ユーザー詳細画面のテスト" do
    before do
      visit user_path(user)
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content user.name
      end
    end
  end
  
  describe "ユーザー編集画面のテスト" do
    before do
      visit edit_user_path(user)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'user[name]', with: user.name
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'user[email]', with: Faker::Lorem.characters(number:20)
        click_button '保存'
        expect(page).to have_current_path mypage_path
      end
    end
  end
  
end