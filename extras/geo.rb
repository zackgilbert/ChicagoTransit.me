module Geo
  
  def self.acos(rad)
  	Math.atan2(Math.sqrt(1 - rad**2), rad)
  end
  
  def self.miles_between(loc1, loc2)
    self.rad2deg(Math.acos((Math.sin(self.deg2rad(loc1[0])) * Math.sin(self.deg2rad(loc2[0]))) + (Math.cos(self.deg2rad(loc1[0])) * Math.cos(self.deg2rad(loc2[0])) * Math.cos(self.deg2rad(loc1[1] - loc2[1]))))) * 60 * 1.1515
  end
  
  def self.deg2rad(deg)
  	(deg * Math::PI / 180)
  end

  def self.rad2deg(rad)
  	(rad * 180 / Math::PI)
  end
  
end