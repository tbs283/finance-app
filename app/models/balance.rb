class Balance < ApplicationRecord
  belongs_to :user
  # belongs_to :expense_genre
  enum balance: {収入: 0, 支出: 1}
  enum genre: {
    その他: 0,
    食費: 1,
    住居費: 2,
    日用品: 3,
    水道光熱費: 4,
    衣服: 5,
    趣味・娯楽: 6,
    教養・教育: 7,
    通信費: 8,
    健康・医療: 9,
    給料: 10,
    お小遣い: 11,
    賞与: 12,
    副業: 13,
    投資: 14,
    臨時収入: 15
  }
  validates :amount,
    presence: true,
    length: { maximum: 7 }

  validates :genre, presence: true
  validates :balance, presence: true
  validates :period, presence: true
end
