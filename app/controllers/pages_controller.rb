class PagesController < ApplicationController

  def index
    session[:last_seen] = nil if session[:last_seen] && session[:last_seen] <= 1.hour.ago
    
    # lets set debug flag
    # if params['debug']
    #   session[:debug] = params['debug'] == 'true' ? true : nil
    # end
    
    # if we've been passed coordinates, store them in a session
    # if params['lat'] && params['lng'] && params['accuracy']
    #   if params['lat'] == 'false'
    #     session[:loc] = nil
    #   else
    #     session[:loc] = [params['lat'].to_f, params['lng'].to_f]
    #     session[:accuracy] = params['accuracy'].to_i
    #     # then clean up the url
    #     redirect_to('/')
    #     return
    #   end
    # end
    
    if get_location && params['locate'].nil?
      # clean up empty ?station= query string in url
      #redirect_to('/') if params['station']
      
      # go through radiuses to find nearest stations
      radii = (get_accuracy <= 2500) ? [0.31,0.41,0.51,0.75,1] : [0.51,0.75,1]
      
      radii.each do |radius|
        @stations = Station.near(:origin => get_location, :within => radius).order("distance ASC").limit(3)
        break if @stations.present?
      end

    else
      @locate = true
      render "locating"
    end
    
    session[:last_seen] = Time.now
  end
  
  def test
    #@loc = [41.90721218416667,-87.67032433916665]
    #lat = 41.90721218416667
    #lat = params['lat'].to_f if params['lat']
    #lng = -87.67032433916665
    #lng = params['lng'].to_f if params['lng']
    #@loc = [lat,lng]
    #@radius = params['radius']||0.75
    #@stations = Station.near(:origin => @loc, :within => @radius).order("distance ASC").limit(3)
  end
  
end
