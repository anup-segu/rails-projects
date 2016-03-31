class TracksController < ApplicationController
  before_action :track_find, only: [:edit, :update, :show]

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      flash[:notice] = "#{@track.class} succesfully created!"
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def show
  end

  def update
    if @track.update_attributes(track_params)
      flash[:notice] = "#{@track.class} succesfully updated!"
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :ttype)
  end

  def track_find
    @track = Track.find(params[:id])
  end
end
