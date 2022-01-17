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

  # 複数条件での検索
  # https://qiita.com/poire_prog/items/48f569cdfc8000e18896 参考
  # scope :search, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
  #   return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

  #   name_search(search_params[:name])
  #     .sex(search_params[:sex])
  #     .age(search_params[:age])
  #     .region(search_params[:region])   #下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  # end

  # scope :name_search, -> (name){where('name LIKE ?', "%#{:name}%") if name.present?}
  # scope :sex, -> (sex){where("sex = ?", :sex) if sex.present?}
  # scope :age, -> (age){where("age = ?", :age) if age.present?}
  # scope :region, -> (region){where("region = ?", :region) if region.present?}

  #フォロー機能
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  #フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end


  attachment :image
  validates :name, presence: true

  enum sex: {男性: 1, 女性: 2}
  enum region: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
    沖縄県:47
  }
  enum age: {１９歳未満: 1, ２０〜２９歳: 2, ３０〜３９歳: 3, ４０〜５９歳: 4, ６０歳以上: 5 }
end
