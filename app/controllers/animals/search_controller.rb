class Animals::SearchController < ApplicationController
  def show
    @animals = Animal.search(params)
  end
end
