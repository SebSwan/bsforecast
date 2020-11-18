class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :destroy, :edit, :update]

  def index
    @spots = Spot.all
  end

  def show
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.save
    redirect_to spots_path
    # show_path(@spot)
  end

  def edit
  end

  def update
    @spot.update(spot_params)
    redirect_to spots_path
    # redirect_to show_path(@spot)
  end

  def destroy
    @spot.destroy

    redirect_to spots_path
  end

  def wizard; end

  def options; end

  private

  def spot_params
    params.require(:spot).permit(:name, :sport, :configuration, :label, :latitude, :longitude, :wind_force_maxi, :wind_force_mini, :wind_direction, :tide_mini, :tide_max, :low_tide, :mid_tide, :high_tide, :coeff_mini, :coeff_maxi, :wave_direction, :wave_height_mini, :wave_height_maxi, :periode_mini, :periode_maxi, :windfinder, :windfindersuper, :shom )
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end

end
