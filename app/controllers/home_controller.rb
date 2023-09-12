class HomeController < ApplicationController
  def index
    @tags = Tag.all
    @animals = params[:name].present? ? Tag.find(params[:name]).animals : Animal.all
    # @animals = params[:tag_id].present? ? Tag.find(params[:tag_id]).animals : Animal.all
    # @tag1 = Tag.find(8)
  end
end
