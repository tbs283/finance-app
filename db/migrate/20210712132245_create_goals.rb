class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.integer :goal_amount
      t.date :goal_limit

      t.timestamps
    end
  end
end
