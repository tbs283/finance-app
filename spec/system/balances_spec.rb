require 'rails_helper'

describe '収支のテスト' do
  let!(:user) { create(:user, name:'test',email: "test@test",password:'111111',password_confirmation:"111111") }
  let!(:balance) { create(:balance, user_id: user.id,amount:10000,balance: 1,description:'description') }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  
  describe '収支一覧/登録画面(balances_path)のテスト' do
    before do
      visit balances_path
    end
    context '一覧表示とリンクの確認' do
      it "balanceの一覧表示(tableタグ)と投稿フォームが同一画面に表示されているか" do
        expect(page).to have_selector 'h5', text: '収入を登録'
        expect(page).to have_field 'balance[amount]'
        expect(page).to have_field 'balance[description]'
      end
      it "balanceの金額を表示し、詳細・削除のリンクが表示されているか" do
        Balance.create(user_id: user.id,amount:10000,balance: 1,description:'description')
        expect(page).to have_link '削除'
        expect(page).to have_link '詳細'
      end
      it '新規登録ボタンが表示されているか' do
        expect(page).to have_button '新規登録'
      end
      it 'balances_pathが"/balances"であるか' do
        expect(current_path).to eq('/balances')
      end
    end
    context 'balance削除のテスト' do
      it 'balanceの削除' do
        expect{ balance.destroy }.to change{ Balance.count }.by(-1)
      end
    end
  end

  describe '収支詳細画面(balance_path)のテスト' do
    before do
      visit balance_path(balance)
    end
    context '表示の確認' do
      it '収支の金額と説明が画面に表示されていること' do
        expect(page).to have_content balance.amount
        expect(page).to have_content balance.description
      end
      it '削除リンクは存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集前の金額と説明がフォームに表示(セット)されている' do
        expect(page).to have_field 'balance[amount]', with: balance.amount
        expect(page).to have_field 'balance[description]', with: balance.description
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    
    context 'balance削除のテスト' do
      it 'balanceの削除' do
        expect{ balance.destroy }.to change{ Balance.count }.by(-1)
      end
    end
    
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'balance[amount]', with: Faker::Commerce.price * 100 
        fill_in 'balance[description]', with: Faker::Lorem.characters(number:10)
        click_button '保存'
        expect(page).to have_current_path balance_path(balance)
      end
    end
  end
end