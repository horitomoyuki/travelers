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
  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  belongs_to :country
  belongs_to :job
  belongs_to :birthplace
  belongs_to :residence
  
  has_one_attached :image

  validates :name, presence: true

  enum gender: { man: 0, woman: 1 }
            
  with_options numericality: { other_than: 1 } do
    validates :country_id
  end

# 検索機能
  def self.search(search)
    if search != ""
      User.where('name LIKE(?)', "%#{search}%")
    else
      User.all
    end
  end

# いいね機能
  def liked(liked_user)
    return if self == liked_user
    favorites.find_or_create_by!(like: liked_user)
  end

  def liking?(user)
    likings.include?(user)
  end

  def unlike(like_ids)
    favorites.where(like_id: like_ids).destroy_all
  end
  
# フォロー機能
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

  # いいね通知
  # def create_notification_follow!(current_user)
  #   temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
  #   if temp.blank?
  #     notification = current_user.active_notifications.new(
  #       visited_id: id,
  #       action: 'follow'
  #     )
  #     notification.save if notification.valid?
  #   end
  # end

  # フォロー通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

# ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.age = 30
      user.country_id = 2
    end
  end
end
