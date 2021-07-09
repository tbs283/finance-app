class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :balance_id
      t.integer :amount

      t.timestamps
    end
  end
end
