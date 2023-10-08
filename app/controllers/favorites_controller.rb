class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @animals = Animal.joins(:favorites).where(favorites: { user_id: params[:user_id] }).page(params[:page]).per(9).order("id DESC")# rubocop:disable all
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
