class AddGenreToBalance < ActiveRecord::Migration[5.2]
  def change
    add_column :balances, :genre, :integer
  end
end
