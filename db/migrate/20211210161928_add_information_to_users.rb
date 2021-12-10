class AddInformationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :region, :integer
    add_column :users, :age, :integer
    add_column :users, :sex, :integer
  end
end
