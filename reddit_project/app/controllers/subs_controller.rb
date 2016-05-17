class SubsController < ApplicationController
  before_action :set_sub, only: [:show, :edit, :update, :destroy]
  before_action :requires_login, only: [:new, :create]
  before_action :requires_moderator, only: [:edit, :update, :destroy]


  # GET /subs
  # GET /subs.json
  def index
    @subs = Sub.all
    render :index
  end

  # GET /subs/1
  # GET /subs/1.json
  def show
    render :show
  end

  # GET /subs/new
  def new
    @sub = Sub.new
    render :new
  end

  # GET /subs/1/edit
  def edit
  end

  # POST /subs
  # POST /subs.json
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /subs/1
  # PATCH/PUT /subs/1.json
  def update

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors]  = @sub.errors.full_messages
      render :edit
    end

  end

  # DELETE /subs/1
  # DELETE /subs/1.json
  def destroy
    @sub.destroy
    redirect_to subs_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sub
    @sub = Sub.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def requires_moderator
    unless current_user == set_sub.moderator
      flash[:errors] = ["You're not the moderator!"]
      redirect_to sub_url(set_sub)
    end
  end
end
