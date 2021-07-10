class IncomeGenre < ApplicationRecord
  belongs_to :balance
  enum name:{
    給料: 0,
    その他: 1
  }
end
