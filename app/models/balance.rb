class Balance < ApplicationRecord
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy
  
end
