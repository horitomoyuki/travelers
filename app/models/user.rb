class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :room_users
  has_many :rooms, through: :room_users
  belongs_to :country
  has_one_attached :image

  validates :name, presence: true
  with_options numericality: { other_than: 1 } do
    validates :country_id
  end
end
