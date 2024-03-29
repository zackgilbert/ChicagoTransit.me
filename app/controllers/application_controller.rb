class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :prepare_for_mobile

  def get_accuracy
    if session[:debug]
       return 1414
    elsif session[:accuracy]
      return session[:accuracy]
    end
    false
  end

  def get_location
    if session[:debug]
      return [41.90721218416667,-87.67032433916665]
    elsif session[:loc]
      return session[:loc] 
    end
    false
  end
  
  def in_miles(meters)
    meters.to_f*0.000621371192
  end
  
  helper_method :get_location, :get_accuracy, :in_miles

  private
  
  def ipad_device?
    if session[:ipad_param]
      session[:ipad_param] == "true" || session[:ipad_param] == "1"
    elsif session[:ipad_param] == "false"
      session[:ipad_param] = nil
      false
    else
      request.user_agent =~ /iPad/
    end
  end
  
  def iphone_device?
    if session[:iphone_param]
      session[:iphone_param] == "true" || session[:iphone_param] == "1"
    elsif session[:iphone_param] == "false"
      session[:iphone_param] = nil
      false
    else
      request.user_agent =~ /iPhone/
    end
  end

  def mobile_device?
    return true if iphone_device? || ipad_device?
    
    if session[:mobile_param]
      session[:mobile_param] == "true" || session[:mobile_param] == "1"
    elsif session[:mobile_param] == "false"
      session[:mobile_param] = nil
      false
    else
      request.user_agent =~ /Mobile|webOS|BlackBerry/
    end
  end
  helper_method :iphone_device?, :ipad_device?, :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    #request.format = :mobile if mobile_device?
    session[:ipad_param] = params[:ipad] if params[:ipad]
    #request.format = :ipad if ipad_device?
    session[:iphone_param] = params[:iphone] if params[:iphone]
    #request.format = :iphone if iphone_device?
  end
end
