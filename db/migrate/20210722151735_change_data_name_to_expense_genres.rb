class ChangeDataNameToExpenseGenres < ActiveRecord::Migration[5.2]
  def change
    change_column :expense_genres, :name, :integer
  end
end
