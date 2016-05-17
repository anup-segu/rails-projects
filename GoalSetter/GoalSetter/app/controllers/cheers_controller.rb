class CheersController < ApplicationController
  before_action :not_goal_author, only: [:create]

  def create
    @cheer = Cheer.new(cheer_params)
    @cheer.user_id = current_user.id

    if @cheer.save
      redirect_to goals_url
    else
      flash[:errors] = @cheer.errors.full_messages
      redirect_to goals_url
    end
  end

  def destroy
    @cheer = Cheer.find(params[:id])
    @cheer.destroy
    redirect_to goals_url
  end

  private
  def cheer_params
    params.require(:cheer).permit(:goal_id)
  end

  def not_goal_author
    if current_goals_ids.include?(params[:cheer][:goal_id].to_i)
      flash[:errors] = ["Can't cheer own goal"]
      redirect_to goals_url
    end
  end

  def current_goals_ids
    current_user.goals.select("id").map(&:id)
  end
end
