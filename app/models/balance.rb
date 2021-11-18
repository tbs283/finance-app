class Balance < ApplicationRecord
  belongs_to :user
  # belongs_to :expense_genre
  enum balance: {収入: 0, 支出: 1}
  enum genre: {
    食費: 1,
    住居費: 2,
    日用品: 3,
    水道光熱費: 4,
    衣服: 5,
    趣味・娯楽: 6,
    教養・教育: 7,
    通信費: 8,
    健康・医療: 9,
    その他: 10,
    給料: 11,
    お小遣い: 12,
    賞与: 13,
    副業: 14,
    投資: 15,
    臨時収入: 16
  }
  validates :amount,
    presence: true,
    length: { maximum: 7 }
end
