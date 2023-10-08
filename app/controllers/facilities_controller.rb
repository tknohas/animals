class FacilitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @facilities = Facility.all.page(params[:page]).order("id DESC")
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    @facility.user_id = current_user.id
    if @facility.save
      redirect_to facilities_path, notice: '施設の登録に成功しました。'
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
    if @facility.user_id != current_user.id
      redirect_to facilities_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @facility = Facility.find(params[:id])
    if @facility.update(facility_params)
      redirect_to facilities_path, notice: '施設の更新に成功しました。'
    else
      render 'edit'
    end
  end

  def destroy
    facility = Facility.find(params[:id])
    facility.destroy
    redirect_to facilities_url, notice: '施設が削除されました。'
  end

  private
  
  def facility_params
    params.require(:facility).permit(:address, :latitude, :longitude, :facility_name, :introduction, :link_to_site)
  end
end
