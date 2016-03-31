class TracksController < ApplicationController
  before_action :require_login
  before_action :track_find, only: [:edit, :update, :show, :destroy]

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
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
    render :show
  end

  def destroy
    album = @track.album
    @track.destroy
    flash[:notice] = "The track was deleted"
    redirect_to album_url(album)
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
    params.require(:track).permit(:name, :album_id, :ttype, :lyrics)
  end

  def track_find
    @track = Track.find(params[:id])
  end
end
