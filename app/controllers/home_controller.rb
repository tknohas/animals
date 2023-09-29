class HomeController < ApplicationController
  def index
    @tags = Tag.all
    @animals = params[:name].present? ? Tag.find(params[:name]).animals : Animal.all
    @animal = Animal.limit(10).order("id DESC ")
  end
end
