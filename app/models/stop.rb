class Stop < ActiveRecord::Base
  belongs_to :station, :primary_key => "cta_id", :foreign_key => "station_cta_id"
  
  #acts_as_mappable :default_units => :miles,
  #                   :default_formula => :sphere
  
  scope :near, lambda{ |*args|
    origin = *args.first[:origin]
    if (origin).is_a?(Array)
      origin_lat, origin_lng = origin
    else
      origin_lat, origin_lng = origin.lat, origin.lng
    end
    origin_lat, origin_lng = deg2rad(origin_lat), deg2rad(origin_lng)
    within = *args.first[:within]
    {
      :conditions => %(
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(stops.lat))*COS(RADIANS(stops.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(stops.lat))*SIN(RADIANS(stops.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(stops.lat)))*3963) <= #{within}
      ),
      :select => %( users.*,
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(stops.lat))*COS(RADIANS(stops.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(stops.lat))*SIN(RADIANS(stops.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(stops.lat)))*3963) AS distance
      )
    }
  }
  
  def self.deg2rad(deg)
  	(deg * Math::PI / 180)
  end

  def self.rad2deg(rad)
  	(rad * 180 / Math::PI)
  end

  def self.acos(rad)
  	Math.atan2(Math.sqrt(1 - rad**2), rad)
  end
  
end
