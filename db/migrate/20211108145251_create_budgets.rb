class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.integer :user_id
      t.integer :food
      t.integer :house
      t.integer :daily
      t.integer :utility
      t.integer :cloth
      t.integer :hobby
      t.integer :liberal_art
      t.integer :communicate
      t.integer :medical
      t.integer :other

      t.timestamps
    end
  end
end
