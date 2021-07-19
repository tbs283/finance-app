require 'rails_helper'

describe 'ブログのテスト' do
  let!(:user) { create(:user, name:'test',email: "test@test",password:'111111',password_confirmation:"111111") }
  let!(:blog) { create(:blog, user_id: user.id,title:'hoge',content:'content') }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  
  describe "投稿画面(new_blog_path)のテスト" do
    before do
      visit new_blog_path
    end
    context '表示の確認' do
      it 'new_blog_pathが"/blogs/new"であるか' do
        expect(current_path).to eq('/blogs/new')
      end
      it "blogの投稿フォームが表示されているか" do
        expect(page).to have_field 'blog[title]'
        expect(page).to have_field 'blog[content]'
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    # context '投稿処理のテスト' do
    #   it '投稿後のリダイレクト先は正しいか' do
    #     fill_in 'blog[title]', with: Faker::Lorem.characters(number:5)
    #     fill_in 'blog[content]', with: Faker::Lorem.characters(number:20)
    #     click_button '投稿'
    #     expect(page).to eq '/blogs/' + Blog.last.id.to_s
    #   end
    # end
  end

  describe "ブログ一覧画面のテスト" do
    before do
      visit blogs_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content blog.title
        expect(page).to have_link blog.title
      end
    end
  end

  describe "ブログ詳細画面のテスト" do
    before do
      visit blog_path(blog)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        click_link '編集'
        expect(current_path).to eq '/blogs/' + blog.id.to_s + '/edit'
      end
    end
    context 'blog削除のテスト' do
      it 'blogの削除' do
        expect{ blog.destroy }.to change{ Blog.count }.by(-1)
      end
    end
  end

  describe 'ブログ編集画面のテスト' do
    before do
      visit edit_blog_path(blog)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'blog[title]', with: blog.title
        expect(page).to have_field 'blog[content]', with: blog.content
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'blog[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'blog[content]', with: Faker::Lorem.characters(number:20)
        click_button '保存'
        expect(page).to have_current_path blog_path(blog)
      end
    end
  end
end