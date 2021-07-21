class Goal < ApplicationRecord
  belongs_to :user
  validates :goal_amount,
    presence: true,
    length: { maximum: 9 }
end
