class UsersController < ApplicationController
  before_action :set_user, only: [:index, :search_index]
  before_action :create_searching_object, only: [:index, :search, :search_index]

  def index
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

  def search
    @users = User.search(params[:keyword])
    @results = @p.result
  end

  def search_index
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :introduction, :age, :country_id, :job_id, :birthplace_id, :residence_id)
  end

  def set_user
    @users = User.where.not(id: current_user.id)
  end

  def create_searching_object
    @p = User.ransack(params[:q])
  end
end
