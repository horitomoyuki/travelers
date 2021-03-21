class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :country

  validates :name, presence: true
  with_options numericality: { other_than: 1 } do
    validates :country_id
  end
end
