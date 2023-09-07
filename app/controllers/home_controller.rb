class HomeController < ApplicationController
  def index
    @categories = Genre.order(:id)
  end
end
