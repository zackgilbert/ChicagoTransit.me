class StationsController < ApplicationController
  include ApplicationHelper

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
        format.json { 
          arrivals = []
          station.arrivals.each do |arrival|
            arrivals << { :run_number => arrival['rn']['$'], :train_route => train_route(arrival['rt']['$']), :destination_name => arrival['destNm']['$'], :time_til => arrival_time(arrival['arrT']['$']), :arrival_time => arrival['arrT']['$'] }
            #<li id="line-<%= arrival['rn']['$'] %>" class="arrival <%= train_route(arrival['rt']['$']) %>">
          	#		<span class="train-info"><%= train_route(arrival['rt']['$']).capitalize %> Line #<%= arrival['rn']['$'] %> to</span>
          	#		<h4><%= arrival['destNm']['$'] %></h4>
          	#		<span class="time-til"><%= arrival_time(arrival['arrT']['$']) %></span>
          	#</li>
          end
          render :json => arrivals.to_json 
        }
      end
    else
      redirect_to('/')
    end
  end

end
