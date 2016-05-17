class SessionController < ApplicationController
  # before_action :already_logged_in, except: [:destroy, :new]

  def new
    @user ||= User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user.nil?
      @user = User.new
      @user.errors[:bad_login] << "Invalid Login"
      render :new
    else
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.try(:reset_session_token!)
    logout!
    redirect_to new_session_url
  end

end
