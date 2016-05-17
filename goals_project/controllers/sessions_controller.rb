class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login!(@user)
      redirect_to goals_url
    else
      @user = User.new
      flash.now[:errors] = ["Incorrect username/password combination"]
      render :new
    end
  end

  def destroy
    logout!
  end
end
