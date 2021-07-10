class RemoveBalanceFromBalances < ActiveRecord::Migration[5.2]
  def change
    remove_column :balances, :balance, :integer
  end
end
