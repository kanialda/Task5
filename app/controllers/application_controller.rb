class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user, :check_current_user
  
  def current_user
    current_user ||= User.where("id = ?", session[:user]).first
  end

  def check_current_user
    if current_user.blank?
      flash[:error] = "Please login first before run the action"
      redirect_to login_url
    else
      current_user
    end
  end

end
