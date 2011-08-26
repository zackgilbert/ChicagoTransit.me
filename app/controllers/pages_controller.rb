class PagesController < ApplicationController

  def index
    require 'cobravsmongoose'
    require 'open-uri'
    
    @station_id = params['station']||'40380'    
    response = open("http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=04dec4048adc48b580220bb154ea0014&mapid=" + @station_id).read
    arrays_of_hashes = CobraVsMongoose.xml_to_hash(response)
    
    @arrivals = arrays_of_hashes['ctatt']['eta']
    
    @station = Station.find_by_cta_id(@station_id)
    @title = @station.name
  end
  
  def test
    
  end
  
end