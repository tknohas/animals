class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @animal = Animal.find(params[:id])
    @animals = Animal.where(user_id: "#{@user.id}")
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :user_image, :username, :profile)
  end
end
