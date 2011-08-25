# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Station.delete_all
#Stop.delete_all

open("doc/stations.csv") do |stations|  
  stations.read.each_line do |station| 
    if station[0] != '#' 
      name, cta_id = station.chomp.split(",")
      Station.find_or_create_by_cta_id(:cta_id => cta_id, :name => name)  
    end
  end
end

open("doc/stops.csv") do |stops|  
  stops.read.each_line do |stop| 
    if stop[0] != '#' 
      cta_id, direction, name, longitude, latitude, station_name, station_id, ada, red, blue, green, brown, purple, purple_express, yellow, pink, orange = stop.chomp.split(",")
      Stop.find_or_create_by_cta_id(:cta_id => cta_id,:direction => direction, :name => name, :longitude => longitude, :latitude => latitude, :station_name => station_name, :station_cta_id => station_id, :ada => ada, :red => red, :blue => blue, :green => green, :brown => brown, :purple => purple, :purple_express => purple_express, :yellow => yellow, :pink => pink, :orange => orange)  
    end
  end
end