class Balance < ApplicationRecord
  belongs_to :user
  # belongs_to :expense_genre
  # belongs_to :income_genre
  enum balance: {収入: 0, 支出: 1}
  enum genre: {
    食費: 0,
    住居費: 1,
    日用品: 2,
    水道光熱費: 3,
    衣服: 4,
    趣味・娯楽: 5,
    教養・教育: 6,
    通信費: 7,
    健康・医療: 8,
    その他: 9,
    給料: 10
  }
  validates :amount,
    presence: true,
    length: { maximum: 7 }
end
