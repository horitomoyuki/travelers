class LikesController < ApplicationController
  before_action :set_user

  def create
    @like = @user.likes.build(user_id: params[:user_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id])
    @like.destroy
  end

  private
  
  def set_user
    @user = User.find_by(id: params[:user_id])
  end

end
