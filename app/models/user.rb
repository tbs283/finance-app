class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :budgets, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :balances, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :budgets, dependent: :destroy
  attachment :image
  validates :name, presence: true
end
