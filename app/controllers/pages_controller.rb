class PagesController < ApplicationController

  def index
    # clear out any location stored in the session
    if params['clear']
      session[:loc] = nil
      redirect_to('/')
      return
    end
    
    # if we've been passed coordinates, store them in a session
    if params['lat'] && params['lng']
      session[:loc] = [params['lat'].to_f,params['lng'].to_f]
      # then clean up the url
      redirect_to('/')
      return
    end
    
    @station_id = params['station']||false
    # if specific station has been supplied,
    if @station_id && @station_id > "0"
      # get that station
      station = Station.find_by_cta_id(@station_id)
      @stations = [station]
      @title = station.name
    elsif session[:loc]
      # clean up empty ?station= query string in url
      redirect_to('/') if params['station']
      
      # go through radiuses to find nearest stations
      radii = [0.3,0.4,0.5,0.75,1]
      which = 0
      begin
        @radius = radii[which]
        @stations = Station.near(:origin => session[:loc], :within => @radius).order("distance ASC").limit(3)
        which =+ 1
      end while @stations.count <= 0
    else
      render "locating"
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
