class Balance < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  enum balance: {収入: 0, 支出: 1}
  validates :amount,
    presence: true,
    length: { maximum: 7 }
end
