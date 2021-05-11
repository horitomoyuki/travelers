class RelationshipsController < ApplicationController
  def create
    @follower = User.find(params[:follower_id])
    current_user.follow(@follower)
    respond_to do |format|
      format.js { render 'create.js.erb' }
    end
  end

  def destroy
    @follower = current_user.relationships.find_by(id: params[:id])&.follower
    current_user.relationships.where(id: params[:id]).destroy_all
    respond_to do |format|
      format.js { render 'destroy.js.erb' }
    end
  end
end