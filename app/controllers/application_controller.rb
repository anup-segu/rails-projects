class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_token!
    user.session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def logout!
    current_user.try(:reset_token!)
    session[:session_token] = nil
    @current_user = nil
  end

  def requires_login
    unless logged_in?
      flash[:errors] = ["Must be logged in"]
      redirect_to subs_url
    end
  end
end
