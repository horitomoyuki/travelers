class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:follower])
    current_user.follow(@other_user)
  end

  def destroy
    @user = current_user.relationships.where(id: params[:user_id])
    current_user.unfollow(params[:user_id])
  end
end
