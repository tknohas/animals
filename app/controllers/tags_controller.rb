class TagsController < ApplicationController
  def search
    @animals = Animal.all
    @tags = Tag.where('name LIKE ?', "%#{params[:name]}%")
  end
end
