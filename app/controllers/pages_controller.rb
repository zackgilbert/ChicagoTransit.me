class PagesController < ApplicationController

  def index
    # if we don't know the user's location...
    if !get_location
      # and they are a mobile device, let's try to find it...
      render 'locating' and return if mobile_device?
      # otherwise, just load non-mobile version of loading page.
      render 'non-mobile' and return
    end
    
    # otherwise, we know the location, so just load the page as normal.
    loc1 = get_location # user's set location
    loc2 = [41.885737, -87.630886]  # location of Clark/Lake
    
    # if user is not in chicago, load that page.
    render 'out-of-town' and return if Geo.miles_between(loc1, loc2) >= 25 
      
    # go through radiuses to find nearest stations
    radii = (get_accuracy <= 2500) ? [0.31,0.41,0.51,0.76,1.1,5.1] : [0.51,1.1,5.1]
    radii.each do |radius|
      # is it more efficient to do this from database
      # or from a method in rails that just goes through each station and filters them by distance?
      Rails.cache.fetch("stations-within-#{radius}-of-#{loc1[0]}-#{loc1[1]}", :expires_in => 1.hour) do
        @stations = Station.near(:origin => loc1, :within => radius).order("d ASC").limit(3)
      end
      #@stations = Station.near(:origin => get_location, :within => radius).order("d ASC").limit(3)
      # if more than 1 station is returned, we are good. no use looking further
      break if @stations.present?
    end
    
    respond_to do |format|
      # if this is an ajax request, only return the page without the template
      format.html { render :layout => !request.xhr? }
    end
    
    ### sudocode
    #     if location is set
    #       if location is not in Chicago (distance >= 25 miles from clark/lake)
    #         display 'out-of-town'
    #       if in Chicago
    #         get 3 closest stations without various radius and display them
    #     if location isn't set
    #       if is a mobile location enabled device
    #         display 'locating'
    #         get location from html5 geo
    #         redirect to /located to set location which redirects to /
    #       if not a mobile location enabled device
    #         display 'non-mobile'
    
    #session[:last_seen] = nil if session[:last_seen] && session[:last_seen] <= 1.hour.ago
    
    # lets set debug flag
    # if params['debug']
    #   session[:debug] = params['debug'] == 'true' ? true : nil
    # end
    
    #     if get_location && params['locate'].nil?
    #       # clean up empty ?station= query string in url
    #       #redirect_to('/') if params['station']
    #       
    #       # go through radiuses to find nearest stations
    #       radii = (get_accuracy <= 2500) ? [0.31,0.41,0.51,0.75,1] : [0.51,0.75,1]
    #       
    #       radii.each do |radius|
    #         @stations = Station.near(:origin => get_location, :within => radius).order("distance ASC").limit(3)
    #         break if @stations.present?
    #       end
    # 
    #     else
    #       @locate = true
    #       render "locating"
    #     end
    
    #session[:last_seen] = Time.now
  end
  
  def located
    # if we've been passed coordinates, store them in a session
    if params['lat'] && params['lng'] && params['accuracy']
      session[:loc] = [params['lat'].to_f, params['lng'].to_f]
      session[:accuracy] = params['accuracy'].to_i
    else
      session[:loc] = nil
    end
    redirect_to('/')
  end
  
  def test    
    loc1 = [params['lat'].to_f, params['lng'].to_f]#[41.88873100222222, -87.63490998222223]
    loc2 = [41.885737, -87.630886]    
    @distance = Geo.miles_between(loc1, loc2)
    
    #if @distance > 20
    # looks like you're outside of chicago.
    
    # function getDistanceBetweenPointsNew($latitude1, $longitude1, $latitude2, $longitude2, $unit = 'Mi') {
    #       $theta = $longitude1 - $longitude2;
    #       $distance = (sin(deg2rad($latitude1)) * sin(deg2rad($latitude2))) + (cos(deg2rad($latitude1)) * cos(deg2rad($latitude2)) * cos(deg2rad($theta)));
    #       $distance = acos($distance);
    #       $distance = rad2deg($distance);
    #       $distance = $distance * 60 * 1.1515;
    #       switch($unit) {
    #         case 'Mi': break;
    #         case 'Km' : $distance = $distance * 1.609344;
    #       }
    #       return (round($distance,2));
    #     }
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
