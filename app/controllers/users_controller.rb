class UsersController < ApplicationController
  before_action :already_logged_in
  
  def new
    @user = User.new
    render :new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      params[:session_token] = @user.session_token
      redirect_to cats_url
    else
      render :new
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :password, :session_token)
    end
end
