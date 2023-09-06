class AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def new
    @animal = Animal.new
  end
  
  def create
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    if @animal.save
      redirect_to animals_path
    else 
      render "new"
    end
  end

  def show
    @animal = Animal.find(params[:id])
    @user = current_user
  end

  def edit
  end

  def update
  end
  
  private
  def animal_params
    params.require(:animal).permit(:animalname, :body, :animal_image, :male_or_female)
  end
end
