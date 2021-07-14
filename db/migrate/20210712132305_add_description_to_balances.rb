class AddDescriptionToBalances < ActiveRecord::Migration[5.2]
  def change
    add_column :balances, :description, :text
  end
end
