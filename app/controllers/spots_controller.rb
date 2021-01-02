require 'nokogiri'
require 'pry'
require 'date'
require 'open-uri'

class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :destroy, :edit, :update]
  # session[:init] = true
  # include Windfinder

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

  def wizard
    debut = Time.now

    @spot_list = Spot.all

    def WindfinderOneSpot(spot)
      data_set = Windfinder.dataset(spot[:windfinder])
      result1 = Windfinder.sort(data_set,spot)
      result2 = Windfinder.sort_by_tide(result1, spot)
      @result = Windfinder.sort_by_wind_direction(result2, spot)
    end

    def WindfinderMultiSpot(spot_list)
      result = []
      spot_list.each {|spot|
        result << WindfinderOneSpot(spot)
      }
      result.flatten
    end

    @result = WindfinderMultiSpot(@spot_list)
    fin = Time.now
    @perf = fin - debut
  end

  def options; end

  private

  def spot_params
    params.require(:spot).permit(:name, :sport, :configuration, :label, :latitude, :longitude, :wind_force_maxi, :wind_force_mini, :tide_mini, :tide_max, :low_tide, :mid_tide, :high_tide, :coeff_mini, :coeff_maxi, :wave_height_mini, :wave_height_maxi, :periode_mini, :periode_maxi, :windfinder, :windfindersuper, :shom, wind_direction_ids:[],wave_direction_ids:[])
  end

  def standard_data_set_params
    params.require(:standard_data_set).permit(:model_name, :spot_name, :data_day_name, :data_time, :data_hour, :data_tide, :data_ws, :data_wg, :data_wdeg, :data_wdir)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end

end
