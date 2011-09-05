class StationsController < ApplicationController
  include ApplicationHelper
  
  def show
    @station_id = params[:id]||false
    @station = Station.find_by_cta_id(@station_id)
    @station.user_loc = get_location # HACK -- set user's current location so we know the distance of the user
    @title = @station.name
    
    respond_to do |format|
      format.html { render :layout => !request.xhr? } # if this is an ajax call, only render page without layout
      # we don't really need json...
      #format.json { 
      #  arrivals = []
      #  @station.arrivals.each do |arrival|
      #    arrivals << { :run_number => arrival['rn']['$'], :train_route => train_route(arrival['rt']['$']), :destination_name => arrival['destNm']['$'], :time_til => arrival_time(arrival['arrT']['$']), :arrival_time => arrival['arrT']['$'] }
      #  end
      #  render :json => arrivals.to_json 
      #}
    end
  end

end
