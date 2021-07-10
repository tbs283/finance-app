class RemoveBalance2FromBalances < ActiveRecord::Migration[5.2]
  def change
    remove_column :balances, :balance, :boolean
  end
end
