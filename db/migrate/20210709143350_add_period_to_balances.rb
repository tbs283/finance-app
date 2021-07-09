class AddPeriodToBalances < ActiveRecord::Migration[5.2]
  def change
    add_column :balances, :period, :date
  end
end
