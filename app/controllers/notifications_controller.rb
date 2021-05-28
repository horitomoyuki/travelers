class NotificationsController < ApplicationController
  def index
    @notification = current_user.passive_notifications
    @notification.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
