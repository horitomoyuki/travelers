class Talk < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :room
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?
  
  def was_attached?
    self.image.attached?
  end

  def create_notification_talk!(current_user, talk_id, visited_id)
    temp_ids = Chat.select(:user_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_chat!(current_user, talk_id, temp_id['user_id'])
    end
    save_notification_chat!(current_user, talk_id, visited_id) if temp_ids.blank?
  end

  def save_notification_chat!(current_user, talk_id, visited_id)
    notification = current_user.active_notifications.new(
      talk_id: talk_id,
      visited_id: visited_id,
      action: 'talk'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
