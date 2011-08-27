class PagesController < ApplicationController

  def index
    @station_id = params['station']||false
    # if specific station has been supplied,
    if @station_id && @station_id > "0"
      # get that station
      station = Station.find_by_cta_id(@station_id)
      @stations = [station]
      @title = station.name
    else
      # clean up empty ?station= query string in url
      redirect_to('/') if params['station']
      
      # get lat/lng values
      lat = 41.90721218416667
      lat = params['lat'].to_f if params['lat']
      lng = -87.67032433916665
      lng = params['lng'].to_f if params['lng']
      @loc = [lat,lng]
      
      # go through radiuses to find nearest stations
      radii = [0.3,0.4,0.5,0.75,1]
      which = 0
      begin
        @radius = radii[which]
        @stations = Station.near(:origin => @loc, :within => @radius).order("distance ASC").limit(3)
        which =+ 1
      end while @stations.count <= 0
    end
  end
  
  def test
    #@loc = [41.90721218416667,-87.67032433916665]
    lat = 41.90721218416667
    lat = params['lat'].to_f if params['lat']
    lng = -87.67032433916665
    lng = params['lng'].to_f if params['lng']
    @loc = [lat,lng]
    @radius = params['radius']||0.75
    @stations = Station.near(:origin => @loc, :within => @radius).order("distance ASC").limit(3)
  end
  
end
