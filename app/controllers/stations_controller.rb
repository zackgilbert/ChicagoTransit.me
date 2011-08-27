class StationsController < ApplicationController

  def index
    redirect_to('/')
  end
  
  def show
    @station_id = params[:id]||false
    # if specific station has been supplied,
    if @station_id && @station_id > "0"
      # get that station
      station = Station.find_by_cta_id(@station_id)
      @stations = [station]
      @title = station.name
      
      respond_to do |format|
        format.html { render 'pages/index' }
        format.json { render :json => station.arrivals.to_json }
      end
    else
      redirect_to('/')
    end
  end

end
