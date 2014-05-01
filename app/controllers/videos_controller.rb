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
      render "new"
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    @video.update(safe_params)
    if @video.save
      redirect_to video_path(@video), notice: "Video successfully updated"
    else
      render "edit"
    end
  end

  private

  def safe_params
    params.require(:video).permit(:url, :description, :rating)
  end
end