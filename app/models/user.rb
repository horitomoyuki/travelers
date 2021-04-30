class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :talks
  has_many :likes

  def already_liked?(user)
    self.likes.exists?(user_id: user.id)
  end

  belongs_to :country
  has_one_attached :image

  validates :name, presence: true
            
  with_options numericality: { other_than: 1 } do
    validates :country_id
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.country_id = 2
    end
  end
end
