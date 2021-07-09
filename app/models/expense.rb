class Expense < ApplicationRecord
  has_many :expense_genres, dependent: :destroy
  belongs_to :balance
end
