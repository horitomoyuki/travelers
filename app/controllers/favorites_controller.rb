class FavoritesController < ApplicationController
  def create
    @liked_user = User.find(params[:like_id])
    current_user.liked(@liked_user)
  end

  def destroy
    @like = current_user.favorites.find_by(id: params[:id]).like
    current_user.favorites.where(id: params[:id]).destroy_all
  end
end
