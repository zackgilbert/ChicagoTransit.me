module Geo
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