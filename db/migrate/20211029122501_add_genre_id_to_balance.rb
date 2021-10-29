class AddGenreIdToBalance < ActiveRecord::Migration[5.2]
  def change
    add_column :balances, :genre_id, :integer
  end
end
