class ChangeDataNameToIncomeGenres < ActiveRecord::Migration[5.2]
  def change
    change_column :income_genres, :name, :integer
  end
end
