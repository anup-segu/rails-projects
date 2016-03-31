class BandsController < ApplicationController
  before_action :find_band, only: [:edit, :update, :destroy, :show]
  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def show
    render :show
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      flash[:notice] = "#{@band.class} successfully created!"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @band.update_attributes(band_params)
      flash[:notice] = "#{@band.class} successfully updated!"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band.delete
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def find_band
    @band = Band.find(params[:id])
  end
end
