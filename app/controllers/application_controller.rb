class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def login!(user)
    @current_user = user
    @current_user.reset_session_token!
    session[generate_session_name] = user.session_token
  end

  def generate_session_name
    "session_token_#{request.remote_ip}".to_sym
  end

  def logout!
    # @current_user = nil
    session.delete(generate_session_name)
  end

  def current_user
    return nil if session[generate_session_name].nil?
    @current_user ||= User.find_by_session_token(session[generate_session_name])
  end

  def already_logged_in
    p generate_session_name
    p session[generate_session_name]
    if session[generate_session_name].nil?
      redirect_to new_session_url
    end
  end

  # def logged_in_same_user
  #   if session[:session_token] != @@session_token
  #     redirect_to new_session_url
  #   end
  # end



end
