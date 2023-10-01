class AnimalsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    #@animals = Animal.all
    @animals = params[:name].present? ? Tag.find(params[:name]).animals : Animal.all.page(params[:page]).per(9).order("id DESC")
    @tags = Tag.all
  end

  def new
    @animal = Animal.new
  end
  
  def create
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    if @animal.save
      redirect_to animals_path, notice: '投稿に成功しました。'
    else 
      render "new"
    end
  end

  def show
    @animal = Animal.find(params[:id])
    @user = current_user
    @animal_tags = @animal.tags
  end

  def edit
    @animal = Animal.find(params[:id])
    if @animal.user != current_user
      redirect_to animals_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal.update(animal_params)
      redirect_to animals_path, notice: '更新に成功しました。'
    else
      render 'edit'
    end
  end
  
  def destroy
    animal = Animal.find(params[:id])
    animal.destroy
    redirect_to animals_url, notice: '投稿が削除されました。'
  end

  private
  def animal_params
    params.require(:animal).permit(:animalname, :body, :male_or_female, { tag_ids: [] }, :category, animal_images: [])
  end
end
