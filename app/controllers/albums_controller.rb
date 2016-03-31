class AlbumsController < ApplicationController
  before_action :require_login
  before_action :find_album, only: [:edit, :update, :destroy, :show]

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:notice] = "#{@album.class} succesfully created!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @album.update_attributes(album_params)
      flash[:notice] = "#{@album.class} succesfully updated!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    band = @album.band
    @album.destroy
    flash[:notice] = "The album was deleted"
    redirect_to band_url(band)
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :ttype)
  end

  def find_album
    @album = Album.find(params[:id])
  end
end
