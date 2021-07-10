class Balance < ApplicationRecord
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy
  enum balance:  {収入: 0, 支出: 1}
end
