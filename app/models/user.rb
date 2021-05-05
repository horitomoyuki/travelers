class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :talks
  has_many :footprints
  # フォロー機能
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user 
  # いいね機能
  has_many :favorites, dependent: :destroy
  has_many :likings, through: :favorites, source: :like
  has_many :passive_favorites, class_name: 'Favorite', foreign_key: 'like_id', dependent: :destroy
  has_many :likes, through: :passive_favorites, source: :user

  belongs_to :country
  belongs_to :job
  belongs_to :birthplace
  belongs_to :residence
  
  has_one_attached :image

  validates :name, presence: true
            
  with_options numericality: { other_than: 1 } do
    validates :country_id
  end

  # def liked_by?(current_user)
  #   likes.where(user_id: current_user.id).exists?
  # end

  def like(other_user)
    return if self == other_user
    favorites.find_or_create_by!(like: other_user)
  end

  def liking?(user)
    likings.include?(user)
  end

  def unlike(favorite_id)
    favorites.find(favorite_id).destroy!
  end
  

  def follow(follower)
    return if self == follower
    relationships.find_or_create_by!(follower: follower)
  end

  def following?(user)
    followings.include?(user)
  end

  def unfollow(follower_ids)
    relationships.where(follower_id: follower_ids).destroy_all
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.country_id = 2
    end
  end
end
