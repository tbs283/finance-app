class AddMoneyToBalances < ActiveRecord::Migration[5.2]
  def change
    add_column :balances, :expense_genre_id, :integer
    add_column :balances, :income_genre_id, :integer
    add_column :balances, :balance, :boolean
    add_column :balances, :amount, :integer
  end
end
