class CatsController < ApplicationController
  helper_method :is_owner?
  before_action :validate_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def validate_owner
    @cat = Cat.find(params[:id])
    if @cat.user_id != current_user.id
      flash[:owner_error] = current_user.user_name + " you don't own this cat!"
      redirect_to cat_url(@cat)
    end
  end

  def is_owner?
    @cat = Cat.find(params[:id])
    @cat.user_id == current_user.id
  end
end
