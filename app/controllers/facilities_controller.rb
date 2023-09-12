class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.all
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    @facility.user_id = current_user.id
    if @facility.save
       # AnimalGenre.maltilevel_genre_create(
      #   @animal,
      #   params[:parent_id],
      #   params[:children_id],
      #   params[:grandchildren_id]
      # )
      redirect_to facilities_path
    else 
      # @animals = Animal.all
      # @genre_parent_array = Genre.genre_parent_array_create
      render "new"
    end
  end

  def show
    @facility = Facility.find(params[:id])
    gon.facility = @facility
  end

  def edit
    @facility = Facility.find(params[:id])
  end

  def update
    @facility = Facility.find(params[:id])
    @facility.update(facility_params)
    redirect_to facilities_path
  end

  def destroy
    @facility = Facility.find(params[:id])
    @facility.destroy
    redirect_to facilities_url, notice: 'Facility was successfully destroyed.'
  end

  private
  def facility_params
    params.require(:facility).permit(:address, :latitude, :longitude, :facility_name, :introduction)
  end
end
