class SpotsController < ApplicationController
  def list
    @spots = Spot.all
  end

  def show
   @spot = Spot.find(params[:id])
  end

  def new; end

  def wizard; end

  def options; end
end
