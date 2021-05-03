class LikesController < ApplicationController
  before_action :set_user

  def create
    @like = current_user.likes.build(user_id: params[:user_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id], id: @user.likes.ids)
    @like.destroy
  end

  private
  
  def set_user
    @user = User.find_by(id: params[:user_id])
  end

end
