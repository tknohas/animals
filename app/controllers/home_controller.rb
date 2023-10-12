class HomeController < ApplicationController
  def index
    @tags = Tag.all
    @animals = params[:name].present? ? Tag.find(params[:name]).animals : Animal.limit(9).order("id DESC")
    @facilities =  Facility.all
    gon.facility = @facilities
  end
end
