class GoalsController < ApplicationController
  def index
    @goals = Goal.where("goals.private = 'f' OR goals.user_id = #{current_user.id}")
      .joins("LEFT OUTER JOIN cheers ON goals.id = cheers.goal_id")
      .group("goals.id")
      .order("COUNT(cheers.id) DESC")
      .includes(:cheers)
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private
  def goal_params
    parsed = params.require(:goal).permit(:title, :description, :private, :progress)
    if parsed[:private]
      if parsed[:private] == "Private"
        parsed[:private] = true
      else
        parsed[:private] = false
      end
    end
    parsed
  end
end
