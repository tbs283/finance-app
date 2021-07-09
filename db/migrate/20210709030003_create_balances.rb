class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.integer :user_id
      t.integer :balance

      t.timestamps
    end
  end
end
