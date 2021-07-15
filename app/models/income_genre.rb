class IncomeGenre < ApplicationRecord
  # has_many :balances, dependent: :destroy
  enum name:{
    給料: 0,
    その他: 1
  }
end
