module ApplicationHelper
  include ActionView::Helpers::DateHelper
  
  def arrival_time(arrival)
    # {"staId"=>{"$"=>"40380"}, "stpId"=>{"$"=>"30375"}, "staNm"=>{"$"=>"Clark/Lake"}, "stpDe"=>{"$"=>"Subway service toward O'Hare"}, "rn"=>{"$"=>"124"}, "rt"=>{"$"=>"Blue"}, "destSt"=>{"$"=>"30171"}, "destNm"=>{"$"=>"O'Hare"}, "trDr"=>{"$"=>"1"}, "prdt"=>{"$"=>"20110912 18:40:11"}, "arrT"=>{"$"=>"20110912 18:42:11"}, "isApp"=>{"$"=>"0"}, "isSch"=>{"$"=>"0"}, "isDly"=>{"$"=>"0"}, "isFlt"=>{"$"=>"0"}}
    return "Approaching" if arrival['isApp']['$'] == "1"
    return "Delayed" if arrival['isDly']['$'] == "1"
    
    time = time_ago_in_words(Time.zone.parse(arrival['arrT']['$']).utc.in_time_zone)
    return "Due" if time == "less than a minute" 
    
    time = time.gsub(/([minutes]+)/, 'min')    
  end

  def train_route(route)
    if route == 'G'
      'green'
    elsif route == 'Pink'
      'pink'
    elsif route == 'Blue'
      'blue'
    elsif route == 'Org'
      'orange'
    elsif route == 'Brn'
      'brown'
    elsif route == 'Y'
      'yellow'
    elsif route == 'P'
      'purple'
    elsif route == 'Red'
      'red'
    else
      route
    end
  end
  
  def use_location? 
    mobile_device? || session[:debug]
  end
  
end
