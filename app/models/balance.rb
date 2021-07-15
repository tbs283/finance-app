class Balance < ApplicationRecord
  belongs_to :user
  # belongs_to :expense_genre
  # belongs_to :income_genre
  enum balance:  {収入: 0, 支出: 1}
  validates :amount, presence: true
end
