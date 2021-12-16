class Budget < ApplicationRecord
  belongs_to :user

  validates :food, presence: true
  validates :house, presence: true
  validates :daily, presence: true
  validates :utility, presence: true
  validates :cloth, presence: true
  validates :hobby, presence: true
  validates :liberal_art, presence: true
  validates :communicate, presence: true
  validates :medical, presence: true
  validates :other, presence: true

end
