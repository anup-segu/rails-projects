class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])

    if user.nil?
      flash.now[:errors] = ['Invalid login, please try again']
      render :new
    else
      login!(user)
      redirect_to bands_url
    end
  end

  def destroy
    logout!
    flash[:notice] = "Thanks for visiting"
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end
end
