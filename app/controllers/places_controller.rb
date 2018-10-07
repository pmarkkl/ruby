class PlacesController < ApplicationController
  def index
  end

  def show
    city = Rails.cache.read("city")
    @place = Rails.cache.read(city).select{ |place| place.id == params[:id] }[0]
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = BeermappingApi.get_weather_in(params[:city])
    Rails.cache.write('city', params[:city])
    url = ""
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end
