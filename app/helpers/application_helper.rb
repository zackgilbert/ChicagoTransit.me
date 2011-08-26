module ApplicationHelper

  def arrival_time(time) 
    time = time_ago_in_words(Time.zone.parse(time).utc.in_time_zone)
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

end
