class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(safe_params)

    if @video.save
      redirect_to video_path(@video), notice: "Video successfully created"
    else
      render new_video_path, notice: "Something went wrong"
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def safe_params
    params.require(:video).permit(:url, :description, :rating)
  end


end