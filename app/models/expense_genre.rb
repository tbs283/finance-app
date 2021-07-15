class ExpenseGenre < ApplicationRecord
  # has_many :balances, dependent: :destroy
  enum name:{
    食費: 0,
    住居費: 1,
    日用品: 2,
    水道光熱費: 3,
    衣服: 4,
    趣味・娯楽: 5,
    教養・教育: 6,
    通信費: 7,
    健康・医療: 8,
    その他: 9
  }
end
