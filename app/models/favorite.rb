class Favorite < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :like, class_name: 'User'
end
