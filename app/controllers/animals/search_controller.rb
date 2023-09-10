class Animals::SearchController < ApplicationController
  def show
    @animals = Animal.search(params)
    @tags = Tag.search(params)
  end
end
