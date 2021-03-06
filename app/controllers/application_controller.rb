class ApplicationController < ActionController::Base
helper_method :login_required
helper_method :current_user
helper_method :logged_in?
helper_method :not_logged_in?
helper_method :log_out


def login_required
  redirect_to('/') if current_user.blank?
end

def current_user
   User.find_by(id: session[:user_id])
end

def logged_in?  
  !current_user.nil?
end

def not_logged_in?  
  current_user.nil?
end

def log_out

  current_user = nil

end

end