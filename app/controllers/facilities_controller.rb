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
      redirect_to facilities_path
    else 
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
    facility = Facility.find(params[:id])
    facility.destroy
    redirect_to facilities_url, notice: 'Facility was successfully destroyed.'
  end

  private
  def facility_params
    params.require(:facility).permit(:address, :latitude, :longitude, :facility_name, :introduction, :link_to_site)
  end
end
