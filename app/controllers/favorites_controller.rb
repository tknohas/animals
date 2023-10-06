class FavoritesController < ApplicationController
  def index
    @animals = Animal.joins(:favorites).where(favorites: { user_id: params[:user_id] })
  end

  def create
    @favorite = current_user.favorites.create(animal_id: params[:animal_id])
    @animal = Animal.find(params[:animal_id])
  end

  def destroy
    @animal = Animal.find(params[:animal_id])
    @favorite = current_user.favorites.find_by(animal_id: @animal.id)
    @favorite.destroy
  end
end
