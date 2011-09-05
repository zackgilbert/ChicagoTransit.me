class Station < ActiveRecord::Base
  has_many :stops, :primary_key => "cta_id", :foreign_key => "station_cta_id"
  
  validates_uniqueness_of :cta_id
  validates_uniqueness_of :name

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
        SIN(#{origin_lat})*SIN(RADIANS(stations.lat)))*3963) AS d
      )
    }
  }
  
  def Station.all_cached
    Rails.cache.fetch("stations", :expires_in => 1.day) do
      Station.all
    end
  end
  
  # grab this stations arrival times
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
  
  # figure out the distance between the user and this station
  def distance
    return self['d'] if self['d']
    return false if !self['user_loc']
    self['d'] = Geo.miles_between(self['user_loc'], [self.lat.to_f, self.lng.to_f])
  end
  
  # hack to be able to send in user's current location
  def user_loc=(loc)
    self['user_loc'] = loc
  end
    
end
