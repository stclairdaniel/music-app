class AlbumsController < ApplicationController

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] ||= []
      flash[:errors] << @album.errors.full_error_messages
      render :new
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    if @album
      render :show
    else
      flash[:errors] ||= []
      flash[:errors] << "Can't find the album you're looking for"
      redirect_to bands_url
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @album.errors.full_error_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to bands_url
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :recording_type)
  end
end