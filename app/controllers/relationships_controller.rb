class RelationshipsController < ApplicationController
  def create
    @follower = User.find(params[:follower_id])
    current_user.follow(@follower)
  end

  def destroy
    # @user = User.find_by(id: params[:user_id])
    @follower = current_user.relationships.find_by(id: params[:id]).follower
    current_user.relationships.where(id: params[:id]).destroy_all
  end
end