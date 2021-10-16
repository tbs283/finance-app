class RemoveGenreFromBalances < ActiveRecord::Migration[5.2]
  def change
    remove_column :balances, :expense_genre_id, :integer
    remove_column :balances, :income_genre_id, :integer
  end
end
