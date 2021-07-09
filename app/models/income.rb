class Income < ApplicationRecord
  has_many :income_genres, dependent: :destroy
  belongs_to :balance
end
