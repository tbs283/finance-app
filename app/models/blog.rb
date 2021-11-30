class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  # タグのリレーションのみ記載
  has_many :blog_tags,dependent: :destroy
  has_many :tags,through: :blog_tags

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
