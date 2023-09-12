class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(animal_id: params[:animal_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @animal = Animal.find(params[:animal_id])
    @favorite = current_user.favorites.find_by(animal_id: @animal.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
