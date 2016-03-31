class AlbumsController < ApplicationController
  def new
    @album = Album.new
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
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    
    if @album.update_attributes(album_params)
      flash[:notice] = "#{@album.class} succesfully updated!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :ttype)
  end
end
