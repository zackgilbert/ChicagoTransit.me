class PagesController < ApplicationController

  def index
    require 'cobravsmongoose'
    require 'open-uri'
    
    @mapid = params['mapid']||'40380'    
    response = open("http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=04dec4048adc48b580220bb154ea0014&mapid=" + @mapid).read
    arrays_of_hashes = CobraVsMongoose.xml_to_hash(response)
    
    @arrivals = arrays_of_hashes['ctatt']['eta']
  end
  
  def test
    
  end
  
end
