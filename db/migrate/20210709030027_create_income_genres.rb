class CreateIncomeGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :income_genres do |t|
      t.integer :income_id
      t.string :name

      t.timestamps
    end
  end
end
