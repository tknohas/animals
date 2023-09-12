class AnimalsController < ApplicationController
  def index
    #@animals = Animal.all
    @animals = params[:name].present? ? Tag.find(params[:name]).animals : Animal.all
    @tags = Tag.all
  end

  def new
    @animal = Animal.new
    #@genre_parent_array = Genre.genre_parent_array_create
  end
  
  def create
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    if @animal.save
       # AnimalGenre.maltilevel_genre_create(
      #   @animal,
      #   params[:parent_id],
      #   params[:children_id],
      #   params[:grandchildren_id]
      # )
      redirect_to animals_path
    else 
      # @animals = Animal.all
      # @genre_parent_array = Genre.genre_parent_array_create
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
  end

  def update
    @animal = Animal.find(params[:id])
    @animal.update(animal_params)
    redirect_to animals_path
  end
  # def get_genre_children
  #   @genre_children = Genre.find(params[:parent_id]).children
  # end

  # def get_genre_grandchildren
  #   @genre_grandchildren = Genre.find(params[:children_id]).children
  # end
  
  private
  def animal_params
    params.require(:animal).permit(:animalname, :body, :animal_image, :male_or_female, { tag_ids: [] }, :category)
  end
end
