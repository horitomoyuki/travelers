class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :talks
  belongs_to :country
  has_one_attached :image

  validates :name, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  validates :password, length: { minimum: 6 }, 
            format: { with: PASSWORD_REGEX, message: "パスワードは６文字以上半角英数字で入力してください" }
            
  with_options numericality: { other_than: 1 } do
    validates :country_id
  end
end
