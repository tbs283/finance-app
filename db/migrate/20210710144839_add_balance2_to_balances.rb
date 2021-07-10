class AddBalance2ToBalances < ActiveRecord::Migration[5.2]
  def change
    add_column :balances, :balance, :integer
  end
end
