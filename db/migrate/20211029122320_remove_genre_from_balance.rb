class RemoveGenreFromBalance < ActiveRecord::Migration[5.2]
  def change
    remove_column :balances, :genre, :string
  end
end
