class Genre < ApplicationRecord
  has_many :balances, dependent: :destroy
end
