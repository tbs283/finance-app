class RemoveGenreIdFromBalance < ActiveRecord::Migration[5.2]
  def change
    remove_column :balances, :genre_id, :integer
  end
end
