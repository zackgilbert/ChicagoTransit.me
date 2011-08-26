class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :prepare_for_mobile

  private
  
  def ipad_device?
    if session[:ipad_param]
      session[:ipad_param] == "1"
    else
      request.user_agent =~ /iPad/
    end
  end
  
  def iphone_device?
    if session[:iphone_param]
      session[:iphone_param] == "1"
    else
      request.user_agent =~ /iPhone/
    end
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :ipad_device?, :iphone_device?, :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
    session[:ipad_param] = params[:ipad] if params[:ipad]
    request.format = :ipad if ipad_device?
    session[:iphone_param] = params[:iphone] if params[:iphone]
    request.format = :iphone if iphone_device?
  end
end
