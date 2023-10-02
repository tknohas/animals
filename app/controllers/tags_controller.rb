class TagsController < ApplicationController
  def search
    @animals = Animal.all
  end
end
