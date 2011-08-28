class Station < ActiveRecord::Base
  has_many :stops, :primary_key => "cta_id", :foreign_key => "station_cta_id"
  
  #acts_as_mappable :default_units => :miles,
  #                   :default_formula => :sphere
  
  scope :near, lambda{ |*args|
    origin = *args.first[:origin]
    if (origin).is_a?(Array)
      origin_lat, origin_lng = origin
    else
      origin_lat, origin_lng = origin.lat, origin.lng
    end
    origin_lat, origin_lng = Geo.deg2rad(origin_lat), Geo.deg2rad(origin_lng)
    within = *args.first[:within]
    cta_id = args.first[:cta_id] ? ") AND (stations.cta_id = '#{args.first[:cta_id]}'" : ''
    {
      :conditions => %(
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(stations.lat))*COS(RADIANS(stations.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(stations.lat))*SIN(RADIANS(stations.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(stations.lat)))*3963) <= #{within[0]}#{cta_id}
      ),
      :select => %( stations.*,
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(stations.lat))*COS(RADIANS(stations.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(stations.lat))*SIN(RADIANS(stations.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(stations.lat)))*3963) AS distance
      )
    }
  }
  
  def arrivals
    require 'cobravsmongoose'
    require 'open-uri'
    
    begin
      response = open("http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=04dec4048adc48b580220bb154ea0014&mapid=" + self.cta_id.to_s).read
      arrays_of_hashes = CobraVsMongoose.xml_to_hash(response)
      
      return [arrays_of_hashes['ctatt']['eta']] if arrays_of_hashes['ctatt']['eta'][0].nil?
      
      arrays_of_hashes['ctatt']['eta']
    rescue
      []
    end
  end
    
end
