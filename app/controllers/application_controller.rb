class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?

  # before_action :require_login

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||=
      User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    unless logged_in?
      flash[:notice] = "Please Log In First"
      redirect_to new_session_url
    end
  end


end
