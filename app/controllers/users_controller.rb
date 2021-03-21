class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :introduction, :age, :country_id)
  end
end
