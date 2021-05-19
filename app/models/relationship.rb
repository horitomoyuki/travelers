class Relationship < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :follower, class_name: 'User'
end
