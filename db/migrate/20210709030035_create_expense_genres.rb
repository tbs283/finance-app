class CreateExpenseGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_genres do |t|
      t.integer :expense_id
      t.string :name

      t.timestamps
    end
  end
end
