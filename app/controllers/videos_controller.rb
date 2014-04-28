class VideosController < ApplicationController

  def index
    @video = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(safe_params)
    redirect_to '/videos'
  end

  private

  def safe_params
    params.require(:video).permit(:url, :description, :rating)
  end


end