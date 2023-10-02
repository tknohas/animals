class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @animals = Animal.where(user_id: "#{@user.id}")
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, alert:'不正なアクセスです。'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: '更新に成功しました。'
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :user_image, :username, :profile)
  end
end
